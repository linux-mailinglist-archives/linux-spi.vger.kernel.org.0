Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908D0134B9D
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 20:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgAHTn2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 14:43:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgAHTn2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jan 2020 14:43:28 -0500
Received: from localhost.localdomain (unknown [83.218.167.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFD420720;
        Wed,  8 Jan 2020 19:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578512606;
        bh=hWwWtMt1+93jGN58NV8wKHXTfPA1J09p+UH01SSPbuw=;
        h=From:To:Cc:Subject:Date:From;
        b=WuMpnVjrgo1QaSa5v0Xm3zGgFqn3RjtpCSPwQwDxF5wslohmYJwq7C78qLbKP7pIM
         IFmZsef8gblEMbIBxJeDeVPHpTJDR9/6eZAFDsG+5C7sOfLvQ7PhUp6ntpi+LEHCp+
         FkUPpPs1W84dW+IznC3tZ/oCcqxzUVXPN9cIHOpw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] spi: sh-msiof: Do not redefine STR while compile testing
Date:   Wed,  8 Jan 2020 20:43:19 +0100
Message-Id: <20200108194319.3171-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

STR is a well-known stringify macro so it should be avoided in drivers
to avoid warnings like this (MIPS architecture while compile testing):

    drivers/spi/spi-sh-msiof.c:76:0: warning: "STR" redefined
     #define STR 0x40 /* Status Register */
    arch/mips/include/asm/mipsregs.h:30:0: note: this is the location of the previous definition
     #define STR(x) __STR(x)

To maintain consistency between all register names add a SI prefix to
all of them.  This also matches register names in datasheet.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Use SI prefix,
2. Adjust all register names.
---
 drivers/spi/spi-sh-msiof.c | 418 ++++++++++++++++++-------------------
 1 file changed, 209 insertions(+), 209 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8f134735291f..d6923f25473d 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -63,140 +63,140 @@ struct sh_msiof_spi_priv {
 
 #define MAX_SS	3	/* Maximum number of native chip selects */
 
-#define TMDR1	0x00	/* Transmit Mode Register 1 */
-#define TMDR2	0x04	/* Transmit Mode Register 2 */
-#define TMDR3	0x08	/* Transmit Mode Register 3 */
-#define RMDR1	0x10	/* Receive Mode Register 1 */
-#define RMDR2	0x14	/* Receive Mode Register 2 */
-#define RMDR3	0x18	/* Receive Mode Register 3 */
-#define TSCR	0x20	/* Transmit Clock Select Register */
-#define RSCR	0x22	/* Receive Clock Select Register (SH, A1, APE6) */
-#define CTR	0x28	/* Control Register */
-#define FCTR	0x30	/* FIFO Control Register */
-#define STR	0x40	/* Status Register */
-#define IER	0x44	/* Interrupt Enable Register */
-#define TDR1	0x48	/* Transmit Control Data Register 1 (SH, A1) */
-#define TDR2	0x4c	/* Transmit Control Data Register 2 (SH, A1) */
-#define TFDR	0x50	/* Transmit FIFO Data Register */
-#define RDR1	0x58	/* Receive Control Data Register 1 (SH, A1) */
-#define RDR2	0x5c	/* Receive Control Data Register 2 (SH, A1) */
-#define RFDR	0x60	/* Receive FIFO Data Register */
-
-/* TMDR1 and RMDR1 */
-#define MDR1_TRMD	   BIT(31)  /* Transfer Mode (1 = Master mode) */
-#define MDR1_SYNCMD_MASK   GENMASK(29, 28) /* SYNC Mode */
-#define MDR1_SYNCMD_SPI	   (2 << 28)/*   Level mode/SPI */
-#define MDR1_SYNCMD_LR	   (3 << 28)/*   L/R mode */
-#define MDR1_SYNCAC_SHIFT  25       /* Sync Polarity (1 = Active-low) */
-#define MDR1_BITLSB_SHIFT  24       /* MSB/LSB First (1 = LSB first) */
-#define MDR1_DTDL_SHIFT	   20       /* Data Pin Bit Delay for MSIOF_SYNC */
-#define MDR1_SYNCDL_SHIFT  16       /* Frame Sync Signal Timing Delay */
-#define MDR1_FLD_MASK	   GENMASK(3, 2) /* Frame Sync Signal Interval (0-3) */
-#define MDR1_FLD_SHIFT	   2
-#define MDR1_XXSTP	   BIT(0)   /* Transmission/Reception Stop on FIFO */
-/* TMDR1 */
-#define TMDR1_PCON	   BIT(30)  /* Transfer Signal Connection */
-#define TMDR1_SYNCCH_MASK  GENMASK(27, 26) /* Sync Signal Channel Select */
-#define TMDR1_SYNCCH_SHIFT 26       /* 0=MSIOF_SYNC, 1=MSIOF_SS1, 2=MSIOF_SS2 */
-
-/* TMDR2 and RMDR2 */
-#define MDR2_BITLEN1(i)	(((i) - 1) << 24) /* Data Size (8-32 bits) */
-#define MDR2_WDLEN1(i)	(((i) - 1) << 16) /* Word Count (1-64/256 (SH, A1))) */
-#define MDR2_GRPMASK1	BIT(0)      /* Group Output Mask 1 (SH, A1) */
-
-/* TSCR and RSCR */
-#define SCR_BRPS_MASK	GENMASK(12, 8) /* Prescaler Setting (1-32) */
-#define SCR_BRPS(i)	(((i) - 1) << 8)
-#define SCR_BRDV_MASK	GENMASK(2, 0) /* Baud Rate Generator's Division Ratio */
-#define SCR_BRDV_DIV_2	0
-#define SCR_BRDV_DIV_4	1
-#define SCR_BRDV_DIV_8	2
-#define SCR_BRDV_DIV_16	3
-#define SCR_BRDV_DIV_32	4
-#define SCR_BRDV_DIV_1	7
-
-/* CTR */
-#define CTR_TSCKIZ_MASK	GENMASK(31, 30) /* Transmit Clock I/O Polarity Select */
-#define CTR_TSCKIZ_SCK	BIT(31)   /*   Disable SCK when TX disabled */
-#define CTR_TSCKIZ_POL_SHIFT 30   /*   Transmit Clock Polarity */
-#define CTR_RSCKIZ_MASK	GENMASK(29, 28) /* Receive Clock Polarity Select */
-#define CTR_RSCKIZ_SCK	BIT(29)   /*   Must match CTR_TSCKIZ_SCK */
-#define CTR_RSCKIZ_POL_SHIFT 28   /*   Receive Clock Polarity */
-#define CTR_TEDG_SHIFT	     27   /* Transmit Timing (1 = falling edge) */
-#define CTR_REDG_SHIFT	     26   /* Receive Timing (1 = falling edge) */
-#define CTR_TXDIZ_MASK	GENMASK(23, 22) /* Pin Output When TX is Disabled */
-#define CTR_TXDIZ_LOW	(0 << 22) /*   0 */
-#define CTR_TXDIZ_HIGH	(1 << 22) /*   1 */
-#define CTR_TXDIZ_HIZ	(2 << 22) /*   High-impedance */
-#define CTR_TSCKE	BIT(15)   /* Transmit Serial Clock Output Enable */
-#define CTR_TFSE	BIT(14)   /* Transmit Frame Sync Signal Output Enable */
-#define CTR_TXE		BIT(9)    /* Transmit Enable */
-#define CTR_RXE		BIT(8)    /* Receive Enable */
-#define CTR_TXRST	BIT(1)    /* Transmit Reset */
-#define CTR_RXRST	BIT(0)    /* Receive Reset */
-
-/* FCTR */
-#define FCTR_TFWM_MASK	GENMASK(31, 29) /* Transmit FIFO Watermark */
-#define FCTR_TFWM_64	(0 << 29) /*  Transfer Request when 64 empty stages */
-#define FCTR_TFWM_32	(1 << 29) /*  Transfer Request when 32 empty stages */
-#define FCTR_TFWM_24	(2 << 29) /*  Transfer Request when 24 empty stages */
-#define FCTR_TFWM_16	(3 << 29) /*  Transfer Request when 16 empty stages */
-#define FCTR_TFWM_12	(4 << 29) /*  Transfer Request when 12 empty stages */
-#define FCTR_TFWM_8	(5 << 29) /*  Transfer Request when 8 empty stages */
-#define FCTR_TFWM_4	(6 << 29) /*  Transfer Request when 4 empty stages */
-#define FCTR_TFWM_1	(7 << 29) /*  Transfer Request when 1 empty stage */
-#define FCTR_TFUA_MASK	GENMASK(26, 20) /* Transmit FIFO Usable Area */
-#define FCTR_TFUA_SHIFT	20
-#define FCTR_TFUA(i)	((i) << FCTR_TFUA_SHIFT)
-#define FCTR_RFWM_MASK	GENMASK(15, 13) /* Receive FIFO Watermark */
-#define FCTR_RFWM_1	(0 << 13) /*  Transfer Request when 1 valid stages */
-#define FCTR_RFWM_4	(1 << 13) /*  Transfer Request when 4 valid stages */
-#define FCTR_RFWM_8	(2 << 13) /*  Transfer Request when 8 valid stages */
-#define FCTR_RFWM_16	(3 << 13) /*  Transfer Request when 16 valid stages */
-#define FCTR_RFWM_32	(4 << 13) /*  Transfer Request when 32 valid stages */
-#define FCTR_RFWM_64	(5 << 13) /*  Transfer Request when 64 valid stages */
-#define FCTR_RFWM_128	(6 << 13) /*  Transfer Request when 128 valid stages */
-#define FCTR_RFWM_256	(7 << 13) /*  Transfer Request when 256 valid stages */
-#define FCTR_RFUA_MASK	GENMASK(12, 4) /* Receive FIFO Usable Area (0x40 = full) */
-#define FCTR_RFUA_SHIFT	4
-#define FCTR_RFUA(i)	((i) << FCTR_RFUA_SHIFT)
-
-/* STR */
-#define STR_TFEMP	BIT(29) /* Transmit FIFO Empty */
-#define STR_TDREQ	BIT(28) /* Transmit Data Transfer Request */
-#define STR_TEOF	BIT(23) /* Frame Transmission End */
-#define STR_TFSERR	BIT(21) /* Transmit Frame Synchronization Error */
-#define STR_TFOVF	BIT(20) /* Transmit FIFO Overflow */
-#define STR_TFUDF	BIT(19) /* Transmit FIFO Underflow */
-#define STR_RFFUL	BIT(13) /* Receive FIFO Full */
-#define STR_RDREQ	BIT(12) /* Receive Data Transfer Request */
-#define STR_REOF	BIT(7)  /* Frame Reception End */
-#define STR_RFSERR	BIT(5)  /* Receive Frame Synchronization Error */
-#define STR_RFUDF	BIT(4)  /* Receive FIFO Underflow */
-#define STR_RFOVF	BIT(3)  /* Receive FIFO Overflow */
-
-/* IER */
-#define IER_TDMAE	BIT(31) /* Transmit Data DMA Transfer Req. Enable */
-#define IER_TFEMPE	BIT(29) /* Transmit FIFO Empty Enable */
-#define IER_TDREQE	BIT(28) /* Transmit Data Transfer Request Enable */
-#define IER_TEOFE	BIT(23) /* Frame Transmission End Enable */
-#define IER_TFSERRE	BIT(21) /* Transmit Frame Sync Error Enable */
-#define IER_TFOVFE	BIT(20) /* Transmit FIFO Overflow Enable */
-#define IER_TFUDFE	BIT(19) /* Transmit FIFO Underflow Enable */
-#define IER_RDMAE	BIT(15) /* Receive Data DMA Transfer Req. Enable */
-#define IER_RFFULE	BIT(13) /* Receive FIFO Full Enable */
-#define IER_RDREQE	BIT(12) /* Receive Data Transfer Request Enable */
-#define IER_REOFE	BIT(7)  /* Frame Reception End Enable */
-#define IER_RFSERRE	BIT(5)  /* Receive Frame Sync Error Enable */
-#define IER_RFUDFE	BIT(4)  /* Receive FIFO Underflow Enable */
-#define IER_RFOVFE	BIT(3)  /* Receive FIFO Overflow Enable */
+#define SITMDR1	0x00	/* Transmit Mode Register 1 */
+#define SITMDR2	0x04	/* Transmit Mode Register 2 */
+#define SITMDR3	0x08	/* Transmit Mode Register 3 */
+#define SIRMDR1	0x10	/* Receive Mode Register 1 */
+#define SIRMDR2	0x14	/* Receive Mode Register 2 */
+#define SIRMDR3	0x18	/* Receive Mode Register 3 */
+#define SITSCR	0x20	/* Transmit Clock Select Register */
+#define SIRSCR	0x22	/* Receive Clock Select Register (SH, A1, APE6) */
+#define SICTR	0x28	/* Control Register */
+#define SIFCTR	0x30	/* FIFO Control Register */
+#define SISTR	0x40	/* Status Register */
+#define SIIER	0x44	/* Interrupt Enable Register */
+#define SITDR1	0x48	/* Transmit Control Data Register 1 (SH, A1) */
+#define SITDR2	0x4c	/* Transmit Control Data Register 2 (SH, A1) */
+#define SITFDR	0x50	/* Transmit FIFO Data Register */
+#define SIRDR1	0x58	/* Receive Control Data Register 1 (SH, A1) */
+#define SIRDR2	0x5c	/* Receive Control Data Register 2 (SH, A1) */
+#define SIRFDR	0x60	/* Receive FIFO Data Register */
+
+/* SITMDR1 and SIRMDR1 */
+#define SIMDR1_TRMD		BIT(31)		/* Transfer Mode (1 = Master mode) */
+#define SIMDR1_SYNCMD_MASK	GENMASK(29, 28)	/* SYNC Mode */
+#define SIMDR1_SYNCMD_SPI	(2 << 28)	/*   Level mode/SPI */
+#define SIMDR1_SYNCMD_LR	(3 << 28)	/*   L/R mode */
+#define SIMDR1_SYNCAC_SHIFT	25		/* Sync Polarity (1 = Active-low) */
+#define SIMDR1_BITLSB_SHIFT	24		/* MSB/LSB First (1 = LSB first) */
+#define SIMDR1_DTDL_SHIFT	20		/* Data Pin Bit Delay for MSIOF_SYNC */
+#define SIMDR1_SYNCDL_SHIFT	16		/* Frame Sync Signal Timing Delay */
+#define SIMDR1_FLD_MASK		GENMASK(3, 2)	/* Frame Sync Signal Interval (0-3) */
+#define SIMDR1_FLD_SHIFT	2
+#define SIMDR1_XXSTP		BIT(0)		/* Transmission/Reception Stop on FIFO */
+/* SITMDR1 */
+#define SITMDR1_PCON		BIT(30)		/* Transfer Signal Connection */
+#define SITMDR1_SYNCCH_MASK	GENMASK(27, 26)	/* Sync Signal Channel Select */
+#define SITMDR1_SYNCCH_SHIFT	26		/* 0=MSIOF_SYNC, 1=MSIOF_SS1, 2=MSIOF_SS2 */
+
+/* SITMDR2 and SIRMDR2 */
+#define SIMDR2_BITLEN1(i)	(((i) - 1) << 24) /* Data Size (8-32 bits) */
+#define SIMDR2_WDLEN1(i)	(((i) - 1) << 16) /* Word Count (1-64/256 (SH, A1))) */
+#define SIMDR2_GRPMASK1		BIT(0)		/* Group Output Mask 1 (SH, A1) */
+
+/* SITSCR and SIRSCR */
+#define SISCR_BRPS_MASK		GENMASK(12, 8)	/* Prescaler Setting (1-32) */
+#define SISCR_BRPS(i)		(((i) - 1) << 8)
+#define SISCR_BRDV_MASK		GENMASK(2, 0)	/* Baud Rate Generator's Division Ratio */
+#define SISCR_BRDV_DIV_2	0
+#define SISCR_BRDV_DIV_4	1
+#define SISCR_BRDV_DIV_8	2
+#define SISCR_BRDV_DIV_16	3
+#define SISCR_BRDV_DIV_32	4
+#define SISCR_BRDV_DIV_1	7
+
+/* SICTR */
+#define SICTR_TSCKIZ_MASK	GENMASK(31, 30)	/* Transmit Clock I/O Polarity Select */
+#define SICTR_TSCKIZ_SCK	BIT(31)		/*   Disable SCK when TX disabled */
+#define SICTR_TSCKIZ_POL_SHIFT	30		/*   Transmit Clock Polarity */
+#define SICTR_RSCKIZ_MASK	GENMASK(29, 28) /* Receive Clock Polarity Select */
+#define SICTR_RSCKIZ_SCK	BIT(29)		/*   Must match CTR_TSCKIZ_SCK */
+#define SICTR_RSCKIZ_POL_SHIFT	28		/*   Receive Clock Polarity */
+#define SICTR_TEDG_SHIFT	27		/* Transmit Timing (1 = falling edge) */
+#define SICTR_REDG_SHIFT	26		/* Receive Timing (1 = falling edge) */
+#define SICTR_TXDIZ_MASK	GENMASK(23, 22)	/* Pin Output When TX is Disabled */
+#define SICTR_TXDIZ_LOW		(0 << 22)	/*   0 */
+#define SICTR_TXDIZ_HIGH	(1 << 22)	/*   1 */
+#define SICTR_TXDIZ_HIZ		(2 << 22)	/*   High-impedance */
+#define SICTR_TSCKE		BIT(15)		/* Transmit Serial Clock Output Enable */
+#define SICTR_TFSE		BIT(14)		/* Transmit Frame Sync Signal Output Enable */
+#define SICTR_TXE		BIT(9)		/* Transmit Enable */
+#define SICTR_RXE		BIT(8)		/* Receive Enable */
+#define SICTR_TXRST		BIT(1)		/* Transmit Reset */
+#define SICTR_RXRST		BIT(0)		/* Receive Reset */
+
+/* SIFCTR */
+#define SIFCTR_TFWM_MASK	GENMASK(31, 29)	/* Transmit FIFO Watermark */
+#define SIFCTR_TFWM_64		(0 << 29)	/*  Transfer Request when 64 empty stages */
+#define SIFCTR_TFWM_32		(1 << 29)	/*  Transfer Request when 32 empty stages */
+#define SIFCTR_TFWM_24		(2 << 29)	/*  Transfer Request when 24 empty stages */
+#define SIFCTR_TFWM_16		(3 << 29)	/*  Transfer Request when 16 empty stages */
+#define SIFCTR_TFWM_12		(4 << 29)	/*  Transfer Request when 12 empty stages */
+#define SIFCTR_TFWM_8		(5 << 29)	/*  Transfer Request when 8 empty stages */
+#define SIFCTR_TFWM_4		(6 << 29)	/*  Transfer Request when 4 empty stages */
+#define SIFCTR_TFWM_1		(7 << 29)	/*  Transfer Request when 1 empty stage */
+#define SIFCTR_TFUA_MASK	GENMASK(26, 20) /* Transmit FIFO Usable Area */
+#define SIFCTR_TFUA_SHIFT	20
+#define SIFCTR_TFUA(i)		((i) << SIFCTR_TFUA_SHIFT)
+#define SIFCTR_RFWM_MASK	GENMASK(15, 13)	/* Receive FIFO Watermark */
+#define SIFCTR_RFWM_1		(0 << 13)	/*  Transfer Request when 1 valid stages */
+#define SIFCTR_RFWM_4		(1 << 13)	/*  Transfer Request when 4 valid stages */
+#define SIFCTR_RFWM_8		(2 << 13)	/*  Transfer Request when 8 valid stages */
+#define SIFCTR_RFWM_16		(3 << 13)	/*  Transfer Request when 16 valid stages */
+#define SIFCTR_RFWM_32		(4 << 13)	/*  Transfer Request when 32 valid stages */
+#define SIFCTR_RFWM_64		(5 << 13)	/*  Transfer Request when 64 valid stages */
+#define SIFCTR_RFWM_128		(6 << 13)	/*  Transfer Request when 128 valid stages */
+#define SIFCTR_RFWM_256		(7 << 13)	/*  Transfer Request when 256 valid stages */
+#define SIFCTR_RFUA_MASK	GENMASK(12, 4)	/* Receive FIFO Usable Area (0x40 = full) */
+#define SIFCTR_RFUA_SHIFT	4
+#define SIFCTR_RFUA(i)		((i) << SIFCTR_RFUA_SHIFT)
+
+/* SISTR */
+#define SISTR_TFEMP		BIT(29) /* Transmit FIFO Empty */
+#define SISTR_TDREQ		BIT(28) /* Transmit Data Transfer Request */
+#define SISTR_TEOF		BIT(23) /* Frame Transmission End */
+#define SISTR_TFSERR		BIT(21) /* Transmit Frame Synchronization Error */
+#define SISTR_TFOVF		BIT(20) /* Transmit FIFO Overflow */
+#define SISTR_TFUDF		BIT(19) /* Transmit FIFO Underflow */
+#define SISTR_RFFUL		BIT(13) /* Receive FIFO Full */
+#define SISTR_RDREQ		BIT(12) /* Receive Data Transfer Request */
+#define SISTR_REOF		BIT(7)  /* Frame Reception End */
+#define SISTR_RFSERR		BIT(5)  /* Receive Frame Synchronization Error */
+#define SISTR_RFUDF		BIT(4)  /* Receive FIFO Underflow */
+#define SISTR_RFOVF		BIT(3)  /* Receive FIFO Overflow */
+
+/* SIIER */
+#define SIIER_TDMAE		BIT(31) /* Transmit Data DMA Transfer Req. Enable */
+#define SIIER_TFEMPE		BIT(29) /* Transmit FIFO Empty Enable */
+#define SIIER_TDREQE		BIT(28) /* Transmit Data Transfer Request Enable */
+#define SIIER_TEOFE		BIT(23) /* Frame Transmission End Enable */
+#define SIIER_TFSERRE		BIT(21) /* Transmit Frame Sync Error Enable */
+#define SIIER_TFOVFE		BIT(20) /* Transmit FIFO Overflow Enable */
+#define SIIER_TFUDFE		BIT(19) /* Transmit FIFO Underflow Enable */
+#define SIIER_RDMAE		BIT(15) /* Receive Data DMA Transfer Req. Enable */
+#define SIIER_RFFULE		BIT(13) /* Receive FIFO Full Enable */
+#define SIIER_RDREQE		BIT(12) /* Receive Data Transfer Request Enable */
+#define SIIER_REOFE		BIT(7)  /* Frame Reception End Enable */
+#define SIIER_RFSERRE		BIT(5)  /* Receive Frame Sync Error Enable */
+#define SIIER_RFUDFE		BIT(4)  /* Receive FIFO Underflow Enable */
+#define SIIER_RFOVFE		BIT(3)  /* Receive FIFO Overflow Enable */
 
 
 static u32 sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
 {
 	switch (reg_offs) {
-	case TSCR:
-	case RSCR:
+	case SITSCR:
+	case SIRSCR:
 		return ioread16(p->mapbase + reg_offs);
 	default:
 		return ioread32(p->mapbase + reg_offs);
@@ -207,8 +207,8 @@ static void sh_msiof_write(struct sh_msiof_spi_priv *p, int reg_offs,
 			   u32 value)
 {
 	switch (reg_offs) {
-	case TSCR:
-	case RSCR:
+	case SITSCR:
+	case SIRSCR:
 		iowrite16(value, p->mapbase + reg_offs);
 		break;
 	default:
@@ -223,12 +223,12 @@ static int sh_msiof_modify_ctr_wait(struct sh_msiof_spi_priv *p,
 	u32 mask = clr | set;
 	u32 data;
 
-	data = sh_msiof_read(p, CTR);
+	data = sh_msiof_read(p, SICTR);
 	data &= ~clr;
 	data |= set;
-	sh_msiof_write(p, CTR, data);
+	sh_msiof_write(p, SICTR, data);
 
-	return readl_poll_timeout_atomic(p->mapbase + CTR, data,
+	return readl_poll_timeout_atomic(p->mapbase + SICTR, data,
 					 (data & mask) == set, 1, 100);
 }
 
@@ -237,7 +237,7 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
 	struct sh_msiof_spi_priv *p = data;
 
 	/* just disable the interrupt and wake up */
-	sh_msiof_write(p, IER, 0);
+	sh_msiof_write(p, SIIER, 0);
 	complete(&p->done);
 
 	return IRQ_HANDLED;
@@ -245,20 +245,20 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
 
 static void sh_msiof_spi_reset_regs(struct sh_msiof_spi_priv *p)
 {
-	u32 mask = CTR_TXRST | CTR_RXRST;
+	u32 mask = SICTR_TXRST | SICTR_RXRST;
 	u32 data;
 
-	data = sh_msiof_read(p, CTR);
+	data = sh_msiof_read(p, SICTR);
 	data |= mask;
-	sh_msiof_write(p, CTR, data);
+	sh_msiof_write(p, SICTR, data);
 
-	readl_poll_timeout_atomic(p->mapbase + CTR, data, !(data & mask), 1,
+	readl_poll_timeout_atomic(p->mapbase + SICTR, data, !(data & mask), 1,
 				  100);
 }
 
 static const u32 sh_msiof_spi_div_array[] = {
-	SCR_BRDV_DIV_1, SCR_BRDV_DIV_2,	 SCR_BRDV_DIV_4,
-	SCR_BRDV_DIV_8,	SCR_BRDV_DIV_16, SCR_BRDV_DIV_32,
+	SISCR_BRDV_DIV_1, SISCR_BRDV_DIV_2, SISCR_BRDV_DIV_4,
+	SISCR_BRDV_DIV_8, SISCR_BRDV_DIV_16, SISCR_BRDV_DIV_32,
 };
 
 static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
@@ -276,7 +276,7 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 
 	div = DIV_ROUND_UP(parent_rate, spi_hz);
 	if (div <= 1024) {
-		/* SCR_BRDV_DIV_1 is valid only if BRPS is x 1/1 or x 1/2 */
+		/* SISCR_BRDV_DIV_1 is valid only if BRPS is x 1/1 or x 1/2 */
 		if (!div_pow && div <= 32 && div > 2)
 			div_pow = 1;
 
@@ -295,10 +295,10 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 		brps = 32;
 	}
 
-	scr = sh_msiof_spi_div_array[div_pow] | SCR_BRPS(brps);
-	sh_msiof_write(p, TSCR, scr);
+	scr = sh_msiof_spi_div_array[div_pow] | SISCR_BRPS(brps);
+	sh_msiof_write(p, SITSCR, scr);
 	if (!(p->ctlr->flags & SPI_CONTROLLER_MUST_TX))
-		sh_msiof_write(p, RSCR, scr);
+		sh_msiof_write(p, SIRSCR, scr);
 }
 
 static u32 sh_msiof_get_delay_bit(u32 dtdl_or_syncdl)
@@ -337,8 +337,8 @@ static u32 sh_msiof_spi_get_dtdl_and_syncdl(struct sh_msiof_spi_priv *p)
 		return 0;
 	}
 
-	val = sh_msiof_get_delay_bit(p->info->dtdl) << MDR1_DTDL_SHIFT;
-	val |= sh_msiof_get_delay_bit(p->info->syncdl) << MDR1_SYNCDL_SHIFT;
+	val = sh_msiof_get_delay_bit(p->info->dtdl) << SIMDR1_DTDL_SHIFT;
+	val |= sh_msiof_get_delay_bit(p->info->syncdl) << SIMDR1_SYNCDL_SHIFT;
 
 	return val;
 }
@@ -357,54 +357,54 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p, u32 ss,
 	 *    1    0         11     11    0    0
 	 *    1    1         11     11    1    1
 	 */
-	tmp = MDR1_SYNCMD_SPI | 1 << MDR1_FLD_SHIFT | MDR1_XXSTP;
-	tmp |= !cs_high << MDR1_SYNCAC_SHIFT;
-	tmp |= lsb_first << MDR1_BITLSB_SHIFT;
+	tmp = SIMDR1_SYNCMD_SPI | 1 << SIMDR1_FLD_SHIFT | SIMDR1_XXSTP;
+	tmp |= !cs_high << SIMDR1_SYNCAC_SHIFT;
+	tmp |= lsb_first << SIMDR1_BITLSB_SHIFT;
 	tmp |= sh_msiof_spi_get_dtdl_and_syncdl(p);
 	if (spi_controller_is_slave(p->ctlr)) {
-		sh_msiof_write(p, TMDR1, tmp | TMDR1_PCON);
+		sh_msiof_write(p, SITMDR1, tmp | SITMDR1_PCON);
 	} else {
-		sh_msiof_write(p, TMDR1,
-			       tmp | MDR1_TRMD | TMDR1_PCON |
-			       (ss < MAX_SS ? ss : 0) << TMDR1_SYNCCH_SHIFT);
+		sh_msiof_write(p, SITMDR1,
+			       tmp | SIMDR1_TRMD | SITMDR1_PCON |
+			       (ss < MAX_SS ? ss : 0) << SITMDR1_SYNCCH_SHIFT);
 	}
 	if (p->ctlr->flags & SPI_CONTROLLER_MUST_TX) {
 		/* These bits are reserved if RX needs TX */
 		tmp &= ~0x0000ffff;
 	}
-	sh_msiof_write(p, RMDR1, tmp);
+	sh_msiof_write(p, SIRMDR1, tmp);
 
 	tmp = 0;
-	tmp |= CTR_TSCKIZ_SCK | cpol << CTR_TSCKIZ_POL_SHIFT;
-	tmp |= CTR_RSCKIZ_SCK | cpol << CTR_RSCKIZ_POL_SHIFT;
+	tmp |= SICTR_TSCKIZ_SCK | cpol << SICTR_TSCKIZ_POL_SHIFT;
+	tmp |= SICTR_RSCKIZ_SCK | cpol << SICTR_RSCKIZ_POL_SHIFT;
 
 	edge = cpol ^ !cpha;
 
-	tmp |= edge << CTR_TEDG_SHIFT;
-	tmp |= edge << CTR_REDG_SHIFT;
-	tmp |= tx_hi_z ? CTR_TXDIZ_HIZ : CTR_TXDIZ_LOW;
-	sh_msiof_write(p, CTR, tmp);
+	tmp |= edge << SICTR_TEDG_SHIFT;
+	tmp |= edge << SICTR_REDG_SHIFT;
+	tmp |= tx_hi_z ? SICTR_TXDIZ_HIZ : SICTR_TXDIZ_LOW;
+	sh_msiof_write(p, SICTR, tmp);
 }
 
 static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 				       const void *tx_buf, void *rx_buf,
 				       u32 bits, u32 words)
 {
-	u32 dr2 = MDR2_BITLEN1(bits) | MDR2_WDLEN1(words);
+	u32 dr2 = SIMDR2_BITLEN1(bits) | SIMDR2_WDLEN1(words);
 
 	if (tx_buf || (p->ctlr->flags & SPI_CONTROLLER_MUST_TX))
-		sh_msiof_write(p, TMDR2, dr2);
+		sh_msiof_write(p, SITMDR2, dr2);
 	else
-		sh_msiof_write(p, TMDR2, dr2 | MDR2_GRPMASK1);
+		sh_msiof_write(p, SITMDR2, dr2 | SIMDR2_GRPMASK1);
 
 	if (rx_buf)
-		sh_msiof_write(p, RMDR2, dr2);
+		sh_msiof_write(p, SIRMDR2, dr2);
 }
 
 static void sh_msiof_reset_str(struct sh_msiof_spi_priv *p)
 {
-	sh_msiof_write(p, STR,
-		       sh_msiof_read(p, STR) & ~(STR_TDREQ | STR_RDREQ));
+	sh_msiof_write(p, SISTR,
+		       sh_msiof_read(p, SISTR) & ~(SISTR_TDREQ | SISTR_RDREQ));
 }
 
 static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
@@ -414,7 +414,7 @@ static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		sh_msiof_write(p, TFDR, buf_8[k] << fs);
+		sh_msiof_write(p, SITFDR, buf_8[k] << fs);
 }
 
 static void sh_msiof_spi_write_fifo_16(struct sh_msiof_spi_priv *p,
@@ -424,7 +424,7 @@ static void sh_msiof_spi_write_fifo_16(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		sh_msiof_write(p, TFDR, buf_16[k] << fs);
+		sh_msiof_write(p, SITFDR, buf_16[k] << fs);
 }
 
 static void sh_msiof_spi_write_fifo_16u(struct sh_msiof_spi_priv *p,
@@ -434,7 +434,7 @@ static void sh_msiof_spi_write_fifo_16u(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		sh_msiof_write(p, TFDR, get_unaligned(&buf_16[k]) << fs);
+		sh_msiof_write(p, SITFDR, get_unaligned(&buf_16[k]) << fs);
 }
 
 static void sh_msiof_spi_write_fifo_32(struct sh_msiof_spi_priv *p,
@@ -444,7 +444,7 @@ static void sh_msiof_spi_write_fifo_32(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		sh_msiof_write(p, TFDR, buf_32[k] << fs);
+		sh_msiof_write(p, SITFDR, buf_32[k] << fs);
 }
 
 static void sh_msiof_spi_write_fifo_32u(struct sh_msiof_spi_priv *p,
@@ -454,7 +454,7 @@ static void sh_msiof_spi_write_fifo_32u(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		sh_msiof_write(p, TFDR, get_unaligned(&buf_32[k]) << fs);
+		sh_msiof_write(p, SITFDR, get_unaligned(&buf_32[k]) << fs);
 }
 
 static void sh_msiof_spi_write_fifo_s32(struct sh_msiof_spi_priv *p,
@@ -464,7 +464,7 @@ static void sh_msiof_spi_write_fifo_s32(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		sh_msiof_write(p, TFDR, swab32(buf_32[k] << fs));
+		sh_msiof_write(p, SITFDR, swab32(buf_32[k] << fs));
 }
 
 static void sh_msiof_spi_write_fifo_s32u(struct sh_msiof_spi_priv *p,
@@ -474,7 +474,7 @@ static void sh_msiof_spi_write_fifo_s32u(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		sh_msiof_write(p, TFDR, swab32(get_unaligned(&buf_32[k]) << fs));
+		sh_msiof_write(p, SITFDR, swab32(get_unaligned(&buf_32[k]) << fs));
 }
 
 static void sh_msiof_spi_read_fifo_8(struct sh_msiof_spi_priv *p,
@@ -484,7 +484,7 @@ static void sh_msiof_spi_read_fifo_8(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		buf_8[k] = sh_msiof_read(p, RFDR) >> fs;
+		buf_8[k] = sh_msiof_read(p, SIRFDR) >> fs;
 }
 
 static void sh_msiof_spi_read_fifo_16(struct sh_msiof_spi_priv *p,
@@ -494,7 +494,7 @@ static void sh_msiof_spi_read_fifo_16(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		buf_16[k] = sh_msiof_read(p, RFDR) >> fs;
+		buf_16[k] = sh_msiof_read(p, SIRFDR) >> fs;
 }
 
 static void sh_msiof_spi_read_fifo_16u(struct sh_msiof_spi_priv *p,
@@ -504,7 +504,7 @@ static void sh_msiof_spi_read_fifo_16u(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		put_unaligned(sh_msiof_read(p, RFDR) >> fs, &buf_16[k]);
+		put_unaligned(sh_msiof_read(p, SIRFDR) >> fs, &buf_16[k]);
 }
 
 static void sh_msiof_spi_read_fifo_32(struct sh_msiof_spi_priv *p,
@@ -514,7 +514,7 @@ static void sh_msiof_spi_read_fifo_32(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		buf_32[k] = sh_msiof_read(p, RFDR) >> fs;
+		buf_32[k] = sh_msiof_read(p, SIRFDR) >> fs;
 }
 
 static void sh_msiof_spi_read_fifo_32u(struct sh_msiof_spi_priv *p,
@@ -524,7 +524,7 @@ static void sh_msiof_spi_read_fifo_32u(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		put_unaligned(sh_msiof_read(p, RFDR) >> fs, &buf_32[k]);
+		put_unaligned(sh_msiof_read(p, SIRFDR) >> fs, &buf_32[k]);
 }
 
 static void sh_msiof_spi_read_fifo_s32(struct sh_msiof_spi_priv *p,
@@ -534,7 +534,7 @@ static void sh_msiof_spi_read_fifo_s32(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		buf_32[k] = swab32(sh_msiof_read(p, RFDR) >> fs);
+		buf_32[k] = swab32(sh_msiof_read(p, SIRFDR) >> fs);
 }
 
 static void sh_msiof_spi_read_fifo_s32u(struct sh_msiof_spi_priv *p,
@@ -544,7 +544,7 @@ static void sh_msiof_spi_read_fifo_s32u(struct sh_msiof_spi_priv *p,
 	int k;
 
 	for (k = 0; k < words; k++)
-		put_unaligned(swab32(sh_msiof_read(p, RFDR) >> fs), &buf_32[k]);
+		put_unaligned(swab32(sh_msiof_read(p, SIRFDR) >> fs), &buf_32[k]);
 }
 
 static int sh_msiof_spi_setup(struct spi_device *spi)
@@ -561,17 +561,17 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		return 0;
 
 	/* Configure native chip select mode/polarity early */
-	clr = MDR1_SYNCMD_MASK;
-	set = MDR1_SYNCMD_SPI;
+	clr = SIMDR1_SYNCMD_MASK;
+	set = SIMDR1_SYNCMD_SPI;
 	if (spi->mode & SPI_CS_HIGH)
-		clr |= BIT(MDR1_SYNCAC_SHIFT);
+		clr |= BIT(SIMDR1_SYNCAC_SHIFT);
 	else
-		set |= BIT(MDR1_SYNCAC_SHIFT);
+		set |= BIT(SIMDR1_SYNCAC_SHIFT);
 	pm_runtime_get_sync(&p->pdev->dev);
-	tmp = sh_msiof_read(p, TMDR1) & ~clr;
-	sh_msiof_write(p, TMDR1, tmp | set | MDR1_TRMD | TMDR1_PCON);
-	tmp = sh_msiof_read(p, RMDR1) & ~clr;
-	sh_msiof_write(p, RMDR1, tmp | set);
+	tmp = sh_msiof_read(p, SITMDR1) & ~clr;
+	sh_msiof_write(p, SITMDR1, tmp | set | SIMDR1_TRMD | SITMDR1_PCON);
+	tmp = sh_msiof_read(p, SIRMDR1) & ~clr;
+	sh_msiof_write(p, SIRMDR1, tmp | set);
 	pm_runtime_put(&p->pdev->dev);
 	p->native_cs_high = spi->mode & SPI_CS_HIGH;
 	p->native_cs_inited = true;
@@ -607,15 +607,15 @@ static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
 
 	/* setup clock and rx/tx signals */
 	if (!slave)
-		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TSCKE);
+		ret = sh_msiof_modify_ctr_wait(p, 0, SICTR_TSCKE);
 	if (rx_buf && !ret)
-		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_RXE);
+		ret = sh_msiof_modify_ctr_wait(p, 0, SICTR_RXE);
 	if (!ret)
-		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TXE);
+		ret = sh_msiof_modify_ctr_wait(p, 0, SICTR_TXE);
 
 	/* start by setting frame bit */
 	if (!ret && !slave)
-		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TFSE);
+		ret = sh_msiof_modify_ctr_wait(p, 0, SICTR_TFSE);
 
 	return ret;
 }
@@ -627,13 +627,13 @@ static int sh_msiof_spi_stop(struct sh_msiof_spi_priv *p, void *rx_buf)
 
 	/* shut down frame, rx/tx and clock signals */
 	if (!slave)
-		ret = sh_msiof_modify_ctr_wait(p, CTR_TFSE, 0);
+		ret = sh_msiof_modify_ctr_wait(p, SICTR_TFSE, 0);
 	if (!ret)
-		ret = sh_msiof_modify_ctr_wait(p, CTR_TXE, 0);
+		ret = sh_msiof_modify_ctr_wait(p, SICTR_TXE, 0);
 	if (rx_buf && !ret)
-		ret = sh_msiof_modify_ctr_wait(p, CTR_RXE, 0);
+		ret = sh_msiof_modify_ctr_wait(p, SICTR_RXE, 0);
 	if (!ret && !slave)
-		ret = sh_msiof_modify_ctr_wait(p, CTR_TSCKE, 0);
+		ret = sh_msiof_modify_ctr_wait(p, SICTR_TSCKE, 0);
 
 	return ret;
 }
@@ -688,11 +688,11 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	fifo_shift = 32 - bits;
 
 	/* default FIFO watermarks for PIO */
-	sh_msiof_write(p, FCTR, 0);
+	sh_msiof_write(p, SIFCTR, 0);
 
 	/* setup msiof transfer mode registers */
 	sh_msiof_spi_set_mode_regs(p, tx_buf, rx_buf, bits, words);
-	sh_msiof_write(p, IER, IER_TEOFE | IER_REOFE);
+	sh_msiof_write(p, SIIER, SIIER_TEOFE | SIIER_REOFE);
 
 	/* write tx fifo */
 	if (tx_buf)
@@ -731,7 +731,7 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	sh_msiof_reset_str(p);
 	sh_msiof_spi_stop(p, rx_buf);
 stop_ier:
-	sh_msiof_write(p, IER, 0);
+	sh_msiof_write(p, SIIER, 0);
 	return ret;
 }
 
@@ -750,7 +750,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 
 	/* First prepare and submit the DMA request(s), as this may fail */
 	if (rx) {
-		ier_bits |= IER_RDREQE | IER_RDMAE;
+		ier_bits |= SIIER_RDREQE | SIIER_RDMAE;
 		desc_rx = dmaengine_prep_slave_single(p->ctlr->dma_rx,
 					p->rx_dma_addr, len, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -765,7 +765,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	}
 
 	if (tx) {
-		ier_bits |= IER_TDREQE | IER_TDMAE;
+		ier_bits |= SIIER_TDREQE | SIIER_TDMAE;
 		dma_sync_single_for_device(p->ctlr->dma_tx->device->dev,
 					   p->tx_dma_addr, len, DMA_TO_DEVICE);
 		desc_tx = dmaengine_prep_slave_single(p->ctlr->dma_tx,
@@ -786,12 +786,12 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	}
 
 	/* 1 stage FIFO watermarks for DMA */
-	sh_msiof_write(p, FCTR, FCTR_TFWM_1 | FCTR_RFWM_1);
+	sh_msiof_write(p, SIFCTR, SIFCTR_TFWM_1 | SIFCTR_RFWM_1);
 
 	/* setup msiof transfer mode registers (32-bit words) */
 	sh_msiof_spi_set_mode_regs(p, tx, rx, 32, len / 4);
 
-	sh_msiof_write(p, IER, ier_bits);
+	sh_msiof_write(p, SIIER, ier_bits);
 
 	reinit_completion(&p->done);
 	if (tx)
@@ -823,10 +823,10 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 		if (ret)
 			goto stop_reset;
 
-		sh_msiof_write(p, IER, 0);
+		sh_msiof_write(p, SIIER, 0);
 	} else {
 		/* wait for tx fifo to be emptied */
-		sh_msiof_write(p, IER, IER_TEOFE);
+		sh_msiof_write(p, SIIER, SIIER_TEOFE);
 		ret = sh_msiof_wait_for_completion(p, &p->done);
 		if (ret)
 			goto stop_reset;
@@ -856,7 +856,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 no_dma_tx:
 	if (rx)
 		dmaengine_terminate_all(p->ctlr->dma_rx);
-	sh_msiof_write(p, IER, 0);
+	sh_msiof_write(p, SIIER, 0);
 	return ret;
 }
 
@@ -1232,12 +1232,12 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 
 	ctlr = p->ctlr;
 	ctlr->dma_tx = sh_msiof_request_dma_chan(dev, DMA_MEM_TO_DEV,
-						 dma_tx_id, res->start + TFDR);
+						 dma_tx_id, res->start + SITFDR);
 	if (!ctlr->dma_tx)
 		return -ENODEV;
 
 	ctlr->dma_rx = sh_msiof_request_dma_chan(dev, DMA_DEV_TO_MEM,
-						 dma_rx_id, res->start + RFDR);
+						 dma_rx_id, res->start + SIRFDR);
 	if (!ctlr->dma_rx)
 		goto free_tx_chan;
 
-- 
2.17.1

