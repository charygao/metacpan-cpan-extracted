//package pt.v1.tea.testapp;

class MainProgram {

    public static void main(String[] args) {
        try {
            TDBC.tdbcRegisterDriver("com.imaginary.sql.msql.MsqlDriver");
        } catch(Exception e) {
            System.out.println(e.getMessage());
        }
    }

}
