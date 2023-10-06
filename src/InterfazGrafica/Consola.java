package InterfazGrafica;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;

public class Consola extends JFrame {
    private JButton analizarButton1;
    private JButton cargarArchivoButton;
    private JTextArea textEntrada;
    private JTextArea textSalida;
    private JPanel mainPanel;
    private JScrollPane panelEntrada;
    private JScrollPane panelSalida;
    private String pathArchivo = "default.txt";
    private BuscadorArchivo buscador = new BuscadorArchivo(this);


    public Consola() {
        setContentPane(mainPanel);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setSize(800,800);
        setVisible(true);
        buscador.setVisible(false);

        analizarButton1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    pathArchivo = buscador.getNombreArchivo();
                    analizarEntrada(pathArchivo);
                } catch (IOException ex) {
                    throw new RuntimeException(ex);
                }
            }
        });
        cargarArchivoButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                buscador.setVisible(true);
                setVisible(false);
            }

        });
    }

    public void analizarEntrada(String nombreArchivo) throws IOException {
        String codigo = textEntrada.getText();
        File archivo = new File(nombreArchivo);

        archivo.createNewFile();
        FileWriter writer = new FileWriter(archivo);
        writer.write(codigo);   //Escribo la entrada del TextArea en un archivo.
        writer.close();

        try {
            FileReader f = new FileReader(nombreArchivo); //Proceso el archivo con el analizador lexico y lo muestro en textSalida
            Lexico lexer = new Lexico(f);
            lexer.next_token();
            String resultadoAnalizadorLexico = lexer.retornarStr();
            String resultoErroresLexico = lexer.retornarErrores();

            if(resultoErroresLexico.isEmpty()){
                textSalida.setText(resultadoAnalizadorLexico);
            }else{
                textSalida.setText(resultadoAnalizadorLexico + "\n" + "ERRORES" + "\n" + resultoErroresLexico);
            }





        } catch (IOException e) {
            textSalida.setText("Archivo no encontrado!.");
        }

    }

    public void setEntrada(String s){
        textEntrada.setText(s);
    }

    public void setPathArchivo(String pathArchivo) {
        this.pathArchivo = pathArchivo;
    }
}
