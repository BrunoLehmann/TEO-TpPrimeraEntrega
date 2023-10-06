package InterfazGrafica;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class BuscadorArchivo extends JFrame{
    private JButton cargarButton;
    private JTextArea textPathArchivo;
    private JPanel panelbuscador;
    private String nombreArchivo = "default.txt";

    public BuscadorArchivo(Consola padre){
        setContentPane(panelbuscador);
        setSize(400,200);
        cargarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                nombreArchivo = textPathArchivo.getText();
                setVisible(false);
                padre.setVisible(true);
                padre.setPathArchivo(nombreArchivo);
                String cuerpoArchivo = "";

                try {
                    String linea;
                    File archivo = new File(nombreArchivo);
                    FileReader reader = new FileReader(archivo);
                    BufferedReader br = new BufferedReader(reader);
                    while ((linea = br.readLine()) != null) {
                        cuerpoArchivo += linea + "\n";
                    }
                    reader.close();
                    padre.setEntrada(cuerpoArchivo);

                } catch (IOException exception) {
                    throw new RuntimeException(exception);
                }
            }
        });
    }

    public String getNombreArchivo() {
        return nombreArchivo;
    }

}
