Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18B4392132
	for <lists+linux-spi@lfdr.de>; Wed, 26 May 2021 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhEZT6P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 May 2021 15:58:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:36808 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234536AbhEZT6O (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 May 2021 15:58:14 -0400
IronPort-SDR: qed7LRwO9bFbXSkjOHSrMXozEWvfDX11tq5zEsm2lK1o6qesW3LJnYtkCbyMSvLbHqxDQSdm45
 RasEVsPPELVA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189935989"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="189935989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 12:56:40 -0700
IronPort-SDR: bpm0GlhV4bhP+fdfHjdQHE2gVsHST2fTFx3Y+CE3ghyauTjNzLtzalb7HDWO44ls2vlX6YoWB7
 MAaDKKzSEz5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="443207393"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 26 May 2021 12:56:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 48FCEB7; Wed, 26 May 2021 22:57:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v1 1/1] spi: Enable tracing of the SPI setup CS selection
Date:   Wed, 26 May 2021 22:56:55 +0300
Message-Id: <20210526195655.75691-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It is helpful to see what state of CS signal was during one
or another SPI operation. All the same for SPI setup.

Enable tracing of the SPI setup and CS selection.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c          |  4 +++
 include/trace/events/spi.h | 57 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 57120dea3273..ff719c1d93f5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -804,6 +804,8 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
 		return;
 
+	trace_spi_set_cs(spi, activate);
+
 	spi->controller->last_cs_enable = enable;
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
@@ -3457,6 +3459,8 @@ int spi_setup(struct spi_device *spi)
 		spi_set_thread_rt(spi->controller);
 	}
 
+	trace_spi_setup(spi, status);
+
 	dev_dbg(&spi->dev, "setup mode %lu, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			spi->mode & SPI_MODE_X_MASK,
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
diff --git a/include/trace/events/spi.h b/include/trace/events/spi.h
index 0dd9171d2ad8..c0d9844befd7 100644
--- a/include/trace/events/spi.h
+++ b/include/trace/events/spi.h
@@ -42,6 +42,63 @@ DEFINE_EVENT(spi_controller, spi_controller_busy,
 
 );
 
+TRACE_EVENT(spi_setup,
+	TP_PROTO(struct spi_device *spi, int status),
+	TP_ARGS(spi, status),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(unsigned long, mode)
+		__field(unsigned int, bits_per_word)
+		__field(unsigned int, max_speed_hz)
+		__field(int, status)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = spi->controller->bus_num;
+		__entry->chip_select = spi->chip_select;
+		__entry->mode = spi->mode;
+		__entry->bits_per_word = spi->bits_per_word;
+		__entry->max_speed_hz = spi->max_speed_hz;
+		__entry->status = status;
+	),
+
+	TP_printk("spi%d.%d setup mode %lu, %s%s%s%s%u bits/w, %u Hz max --> %d",
+		  __entry->bus_num, __entry->chip_select,
+		  (__entry->mode & SPI_MODE_X_MASK),
+		  (__entry->mode & SPI_CS_HIGH) ? "cs_high, " : "",
+		  (__entry->mode & SPI_LSB_FIRST) ? "lsb, " : "",
+		  (__entry->mode & SPI_3WIRE) ? "3wire, " : "",
+		  (__entry->mode & SPI_LOOP) ? "loopback, " : "",
+		  __entry->bits_per_word, __entry->max_speed_hz,
+		  __entry->status)
+);
+
+TRACE_EVENT(spi_set_cs,
+	TP_PROTO(struct spi_device *spi, bool enable),
+	TP_ARGS(spi, enable),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(unsigned long, mode)
+		__field(bool, enable)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = spi->controller->bus_num;
+		__entry->chip_select = spi->chip_select;
+		__entry->mode = spi->mode;
+		__entry->enable = enable;
+	),
+
+	TP_printk("spi%d.%d %s%s",
+		  __entry->bus_num, __entry->chip_select,
+		  __entry->enable ? "activate" : "deactivate",
+		  (__entry->mode & SPI_CS_HIGH) ? ", cs_high" : "")
+);
+
 DECLARE_EVENT_CLASS(spi_message,
 
 	TP_PROTO(struct spi_message *msg),
-- 
2.30.2

