Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58393533F30
	for <lists+linux-spi@lfdr.de>; Wed, 25 May 2022 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiEYO3t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 May 2022 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiEYO3q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 May 2022 10:29:46 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1F512AB9
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=/LqsGV8CCKS0NwcvSUEMN4n0wsmhpHqXbZZumDaz+6I=;
        b=tzxvXUgv8ukAOsWRAKq0mfkoFAqcDxy/yhKvztT1O6qCZ8t5FYZZfyr4v2MDE9b0msUc5vspDxeD7
         S4meBzFh6HyPpciMhjPEd0o0H2gymmNqRrnhPlxGfkwbWHzX/5IprwNJO6day6TkHy20pedN3tpmzq
         2mpmDOK1f9+sqbmjVsMrksypo9FPIsuSK/EqtfSoi8UWW7tRBQ5AV+PYaV6mJRFMDSY09fv8kRicVf
         7ACFH1JX4Q8qXR9Y/OPoVT12MdwVimSW7HXenkoDMVTGHs9syRoonNs88FoZsLip7J8RFnyKzlvrNI
         sPm5LaSqlZOB68/GnH063CEDYTpgBdQ==
X-MSG-ID: 1bd3f0f9-dc37-11ec-a2aa-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [RFC] [PATCH 1/3] drivers: spi: API: spi_finalize_current_message -> spi_finalize_message
Date:   Wed, 25 May 2022 16:29:26 +0200
Message-Id: <20220525142928.2335378-2-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525142928.2335378-1-david@protonic.nl>
References: <20220525142928.2335378-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change is necessary in order to prepare the SPI core to optimize
different code paths.
This function is the only one that requires every SPI message to go
through the same message queue, because it relies on ctlr->cur_msg to be
the message that has just been transferred.
Accessing this queue requires the use of the corresponding spinlocks
wherever applicable, which have a sizable performance penalty (see next
patch(es)). Forcibly using the queue even for spi_sync also has the
drawback that controller tear-down is always bounced to the worker thread,
introducing an extra context switch.

Signed-off-by: David Jander <david@protonic.nl>
---
 Documentation/spi/spi-summary.rst             |  4 +--
 .../media/pci/netup_unidvb/netup_unidvb_spi.c |  2 +-
 drivers/media/usb/msi2500/msi2500.c           |  2 +-
 drivers/spi/spi-amd.c                         |  2 +-
 drivers/spi/spi-ar934x.c                      |  2 +-
 drivers/spi/spi-axi-spi-engine.c              |  2 +-
 drivers/spi/spi-bcm63xx-hsspi.c               |  2 +-
 drivers/spi/spi-bcm63xx.c                     |  2 +-
 drivers/spi/spi-cavium.c                      |  2 +-
 drivers/spi/spi-falcon.c                      |  2 +-
 drivers/spi/spi-fsi.c                         |  2 +-
 drivers/spi/spi-fsl-dspi.c                    |  2 +-
 drivers/spi/spi-fsl-espi.c                    |  2 +-
 drivers/spi/spi-fsl-spi.c                     |  2 +-
 drivers/spi/spi-mpc512x-psc.c                 |  2 +-
 drivers/spi/spi-mt7621.c                      |  2 +-
 drivers/spi/spi-mtk-nor.c                     |  2 +-
 drivers/spi/spi-mux.c                         |  2 +-
 drivers/spi/spi-mxs.c                         |  2 +-
 drivers/spi/spi-omap-100k.c                   |  2 +-
 drivers/spi/spi-pic32-sqi.c                   |  2 +-
 drivers/spi/spi-pl022.c                       |  4 ++-
 drivers/spi/spi-sc18is602.c                   |  2 +-
 drivers/spi/spi-sh-hspi.c                     |  2 +-
 drivers/spi/spi-tegra114.c                    |  2 +-
 drivers/spi/spi-tegra20-sflash.c              |  2 +-
 drivers/spi/spi-tegra210-quad.c               |  2 +-
 drivers/spi/spi-ti-qspi.c                     |  2 +-
 drivers/spi/spi-xcomm.c                       |  2 +-
 drivers/spi/spi.c                             | 26 ++++++++-----------
 drivers/staging/greybus/spilib.c              |  2 +-
 include/linux/spi/spi.h                       |  5 ++--
 32 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index aab5d07cb3d7..94e8b97a2ae1 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -561,8 +561,8 @@ SPI Master Methods
 	The subsystem calls the driver to transfer a single message while
 	queuing transfers that arrive in the meantime. When the driver is
 	finished with this message, it must call
-	spi_finalize_current_message() so the subsystem can issue the next
-	message. This may sleep.
+	spi_finalize_message() so the subsystem can issue the next message.
+	This may sleep.
 
 ``master->transfer_one(struct spi_master *master, struct spi_device *spi, struct spi_transfer *transfer)``
 	The subsystem calls the driver to transfer a single transfer while
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c b/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
index 526042d8afae..5eda47bc6cf3 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
@@ -161,7 +161,7 @@ static int netup_spi_transfer(struct spi_master *master,
 	}
 done:
 	msg->status = result;
-	spi_finalize_current_message(master);
+	spi_finalize_message(msg);
 	return result;
 }
 
diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 71de6b4c4e4c..f5d8c9ccb8fa 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -1154,7 +1154,7 @@ static int msi2500_transfer_one_message(struct spi_master *master,
 	}
 
 	m->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 	return ret;
 }
 
diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index cba6a4486c24..85bd61f5358c 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -248,7 +248,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 		return -ENODEV;
 	}
 
-	spi_finalize_current_message(master);
+	spi_finalize_message(message);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
index ec7250c4c810..913538b07fcc 100644
--- a/drivers/spi/spi-ar934x.c
+++ b/drivers/spi/spi-ar934x.c
@@ -150,7 +150,7 @@ static int ar934x_spi_transfer_one_message(struct spi_controller *master,
 
 msg_done:
 	m->status = stat;
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 80c3e38f5c1b..f0160372631a 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -396,7 +396,7 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 			msg->status = 0;
 			msg->actual_length = msg->frame_length;
 			spi_engine->msg = NULL;
-			spi_finalize_current_message(master);
+			spi_finalize_message(msg);
 			disable_int |= SPI_ENGINE_INT_SYNC;
 		}
 	}
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index b871fd810d80..dc0782fa8bc9 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -307,7 +307,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	mutex_unlock(&bs->bus_mutex);
 
 	msg->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_message(msg);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 80fa0ef8909c..9beb4bd73837 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -395,7 +395,7 @@ static int bcm63xx_spi_transfer_one(struct spi_master *master,
 	}
 exit:
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-cavium.c b/drivers/spi/spi-cavium.c
index 6854c3ce423b..686e9329bbbc 100644
--- a/drivers/spi/spi-cavium.c
+++ b/drivers/spi/spi-cavium.c
@@ -145,6 +145,6 @@ int octeon_spi_transfer_one_message(struct spi_master *master,
 err:
 	msg->status = status;
 	msg->actual_length = total_len;
-	spi_finalize_current_message(master);
+	spi_finalize_message(msg);
 	return status;
 }
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index a7d4dffac66b..532101c35c5b 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -382,7 +382,7 @@ static int falcon_sflash_xfer_one(struct spi_master *master,
 	}
 
 	m->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index d403a7a3021d..8f8a4d1ea56a 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -502,7 +502,7 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 
 error:
 	mesg->status = rc;
-	spi_finalize_current_message(ctlr);
+	spi_finalize_message(mesg);
 
 	return rc;
 }
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index fd004c9db9dc..a782553a5dd8 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -967,7 +967,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	}
 
 	message->status = status;
-	spi_finalize_current_message(ctlr);
+	spi_finalize_message(message);
 
 	return status;
 }
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f7066bef7b06..0feee3a1e7f4 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -470,7 +470,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	if (m->status == -EINPROGRESS)
 		m->status = ret;
 
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bdf94cc7be1a..5091711c5bb2 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -432,7 +432,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	}
 
 	fsl_spi_setup_transfer(spi, NULL);
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 	return 0;
 }
 
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 03630359ce70..36ca374f815b 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -336,7 +336,7 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 
 	mpc512x_psc_spi_transfer_setup(spi, NULL);
 
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 	return status;
 }
 
diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index b4b9b7309b5e..6f274458ef45 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -293,7 +293,7 @@ static int mt7621_spi_transfer_one_message(struct spi_controller *master,
 
 msg_done:
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 94fb09696677..5efb55f8a5fb 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -682,7 +682,7 @@ static int mtk_nor_transfer_one_message(struct spi_controller *master,
 	m->actual_length = trx_len;
 msg_done:
 	m->status = stat;
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index f5d32ec4634e..98a0bcdbaefb 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -92,7 +92,7 @@ static void spi_mux_complete_cb(void *context)
 	m->complete = priv->child_msg_complete;
 	m->context = priv->child_msg_context;
 	m->spi = priv->child_msg_dev;
-	spi_finalize_current_message(ctlr);
+	spi_finalize_message(m);
 	mux_control_deselect(priv->mux);
 }
 
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 435309b09227..bc8cbb7c6fbd 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -432,7 +432,7 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 	}
 
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return status;
 }
diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 20b047172965..50585441ad52 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -335,7 +335,7 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 
 	m->status = status;
 
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return status;
 }
diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 86ad17597f5f..1bde94845c55 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -434,7 +434,7 @@ static int pic32_sqi_one_message(struct spi_master *master,
 		/* release ring descr */
 		ring_desc_put(sqi, rdesc);
 	}
-	spi_finalize_current_message(spi->master);
+	spi_finalize_message(msg);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index e4484ace584e..93e2da9c653d 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -474,6 +474,7 @@ static void pl022_cs_control(struct pl022 *pl022, u32 command)
 static void giveback(struct pl022 *pl022)
 {
 	struct spi_transfer *last_transfer;
+	struct spi_message *msg;
 	pl022->next_msg_cs_active = false;
 
 	last_transfer = list_last_entry(&pl022->cur_msg->transfers,
@@ -515,6 +516,7 @@ static void giveback(struct pl022 *pl022)
 
 	}
 
+	msg = pl022->cur_msg;
 	pl022->cur_msg = NULL;
 	pl022->cur_transfer = NULL;
 	pl022->cur_chip = NULL;
@@ -523,7 +525,7 @@ static void giveback(struct pl022 *pl022)
 	writew((readw(SSP_CR1(pl022->virtbase)) &
 		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
 
-	spi_finalize_current_message(pl022->master);
+	spi_finalize_message(msg);
 }
 
 /**
diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 5d27ee482237..cf7aec06338b 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -214,7 +214,7 @@ static int sc18is602_transfer_one(struct spi_master *master,
 		spi_transfer_delay_exec(t);
 	}
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return status;
 }
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index a62034e2a7cb..6042f2b50f4f 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -204,7 +204,7 @@ static int hspi_transfer_one_message(struct spi_controller *ctlr,
 		ndelay(nsecs);
 		hspi_hw_cs_disable(hspi);
 	}
-	spi_finalize_current_message(ctlr);
+	spi_finalize_message(msg);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 8f345247a8c3..e3ab93812ce7 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1118,7 +1118,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	ret = 0;
 exit:
 	msg->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_message(msg);
 	return ret;
 }
 
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 2888d8a8dc6d..c118aa59503d 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -351,7 +351,7 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 exit:
 	tegra_sflash_writel(tsd, tsd->def_command_reg, SPI_COMMAND);
 	msg->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_message(msg);
 	return ret;
 }
 
diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 66f647f32876..af647006d312 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1289,7 +1289,7 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master,
 	else
 		ret = tegra_qspi_non_combined_seq_xfer(tqspi, msg);
 
-	spi_finalize_current_message(master);
+	spi_finalize_message(msg);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index e06aafe169e0..20d2e98ee15e 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -718,7 +718,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 
 	ti_qspi_write(qspi, qspi->cmd | QSPI_INVAL, QSPI_SPI_CMD_REG);
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_message(m);
 
 	return status;
 }
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 1d9b3f03d986..bda9ac0f3a16 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -197,7 +197,7 @@ static int spi_xcomm_transfer_one(struct spi_master *master,
 		spi_xcomm_chipselect(spi_xcomm, spi, false);
 
 	msg->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_message(msg);
 
 	return status;
 }
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 842434d544fe..89c7d507f38f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1531,7 +1531,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	if (msg->status && ctlr->handle_err)
 		ctlr->handle_err(ctlr, msg);
 
-	spi_finalize_current_message(ctlr);
+	spi_finalize_message(msg);
 
 	return ret;
 }
@@ -1676,7 +1676,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 				pm_runtime_put(ctlr->dev.parent);
 
 			msg->status = ret;
-			spi_finalize_current_message(ctlr);
+			spi_finalize_message(msg);
 
 			mutex_unlock(&ctlr->io_mutex);
 			return;
@@ -1691,7 +1691,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 			dev_err(&ctlr->dev, "failed to prepare message: %d\n",
 				ret);
 			msg->status = ret;
-			spi_finalize_current_message(ctlr);
+			spi_finalize_message(msg);
 			goto out;
 		}
 		ctlr->cur_msg_prepared = true;
@@ -1700,7 +1700,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	ret = spi_map_msg(ctlr, msg);
 	if (ret) {
 		msg->status = ret;
-		spi_finalize_current_message(ctlr);
+		spi_finalize_message(msg);
 		goto out;
 	}
 
@@ -1896,23 +1896,19 @@ struct spi_message *spi_get_next_queued_message(struct spi_controller *ctlr)
 EXPORT_SYMBOL_GPL(spi_get_next_queued_message);
 
 /**
- * spi_finalize_current_message() - the current message is complete
- * @ctlr: the controller to return the message to
+ * spi_finalize_message() - the current message is complete
+ * @mesg: the message to return to its controller.
  *
- * Called by the driver to notify the core that the message in the front of the
- * queue is complete and can be removed from the queue.
+ * Called by the driver to notify the core that this message is complete and
+ * can be removed from the queue if it was a queued message.
  */
-void spi_finalize_current_message(struct spi_controller *ctlr)
+void spi_finalize_message(struct spi_message *mesg)
 {
+	struct spi_controller *ctlr = mesg->spi->controller;
 	struct spi_transfer *xfer;
-	struct spi_message *mesg;
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&ctlr->queue_lock, flags);
-	mesg = ctlr->cur_msg;
-	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
-
 	if (!ctlr->ptp_sts_supported && !ctlr->transfer_one) {
 		list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
 			ptp_read_system_postts(xfer->ptp_sts);
@@ -1956,7 +1952,7 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 	if (mesg->complete)
 		mesg->complete(mesg->context);
 }
-EXPORT_SYMBOL_GPL(spi_finalize_current_message);
+EXPORT_SYMBOL_GPL(spi_finalize_message);
 
 static int spi_start_queue(struct spi_controller *ctlr)
 {
diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
index ad0700a0bb81..ed7f639e3cfc 100644
--- a/drivers/staging/greybus/spilib.c
+++ b/drivers/staging/greybus/spilib.c
@@ -371,7 +371,7 @@ static int gb_spi_transfer_one_message(struct spi_master *master,
 out:
 	msg->status = ret;
 	clean_xfer_state(spi);
-	spi_finalize_current_message(master);
+	spi_finalize_message(msg);
 
 	return ret;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 29c889825a96..58fc2ed03758 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -394,8 +394,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @transfer_one_message: the subsystem calls the driver to transfer a single
  *	message while queuing transfers that arrive in the meantime. When the
  *	driver is finished with this message, it must call
- *	spi_finalize_current_message() so the subsystem can issue the next
- *	message
+ *	spi_finalize_message() so the subsystem can issue the next message
  * @unprepare_transfer_hardware: there are currently no more messages on the
  *	queue so the subsystem notifies the driver that it may relax the
  *	hardware by issuing this call
@@ -706,7 +705,7 @@ extern int spi_controller_resume(struct spi_controller *ctlr);
 
 /* Calls the driver make to interact with the message queue */
 extern struct spi_message *spi_get_next_queued_message(struct spi_controller *ctlr);
-extern void spi_finalize_current_message(struct spi_controller *ctlr);
+extern void spi_finalize_message(struct spi_message *mesg);
 extern void spi_finalize_current_transfer(struct spi_controller *ctlr);
 
 /* Helper calls for driver to timestamp transfer */
-- 
2.32.0

