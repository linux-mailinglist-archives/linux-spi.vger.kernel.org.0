Return-Path: <linux-spi+bounces-315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2436817448
	for <lists+linux-spi@lfdr.de>; Mon, 18 Dec 2023 15:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54384B21B7F
	for <lists+linux-spi@lfdr.de>; Mon, 18 Dec 2023 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D6101DB;
	Mon, 18 Dec 2023 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WzmbKRKY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8937868
	for <linux-spi@vger.kernel.org>; Mon, 18 Dec 2023 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ba04b9b103so2674040b6e.0
        for <linux-spi@vger.kernel.org>; Mon, 18 Dec 2023 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702911265; x=1703516065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FREtY3NSdNmTblDtEYIxtVbu7iCuXd8sT4Fkk6MN8mg=;
        b=WzmbKRKYUEdqIbRgwf8hvQxF3yHqrVDBq1nVvS7Q7mLrqmCTjcYfLI+e79385YATF2
         dGH4uqUo/aB9XKHzIt6GvoY9uLN+elUIsBBM0FqH8GuKdSrByFf8iXLnXB/2T1PdWXGD
         ahwJLeWkR+5G5F19LiOA5pp6aYAhdqrnw7GlrpAlJrjUSoCwCVTLYiGHazx66UfD9hTh
         Ph2rJV5IBJ1J0X02Nk5tp6Q4XfW5/+NXfhwVR0mFyy2rUNgV9exS/sMXUzOMtxRgrYmc
         pCv0ACRrDVVaioNFjusdsXIYaUrMBwEMt+OTMtdf2t0kD+BDfz3rJhYhy7XanbFWxhse
         ZSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911265; x=1703516065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FREtY3NSdNmTblDtEYIxtVbu7iCuXd8sT4Fkk6MN8mg=;
        b=hgGjTpv/pdHebeLierX4mOivZIXObmrbLxCV68NT747g8k1nkisreNXtex4Tej4e5j
         LHdP8eIf/jUIbpwTqxqwz76oVOwB+NbHberh0R+4fRhACl/79C5dmb1iXPTOG2NJJuFv
         GqD3CVl1o6A1+s2qekk1xtl2n4gTbokM9H4uhO4uE9yNY3iA7T1etqn6OmmJSbNnt2wD
         zs7RNoOFGLMJ83FX4v0vVFbbuzZo847iYJxSvpiWnLpcRabUoyxGDQJo3TfFuaFGeCgT
         xsUMDrNMcrVEXvkKNQEL/foGB70SrAzoyMUpnNjwPX1iFysOf5UqZSPBmNASPrL4sPHk
         Lh0Q==
X-Gm-Message-State: AOJu0YyMWLW7qsqKUliC8Mr70nMf5tEgz1wELWk+xa9C4EsrkZmkSvJ5
	bLQ2XucMudCGz+e8Ti99I2UrzA==
X-Google-Smtp-Source: AGHT+IHxwqJSf7ize+OnsSKpXmz8tNLEfpo7C3J5nLaMy+bW91MtOmDs6t1KZ9eUbyPQzPjwwmy9zg==
X-Received: by 2002:a05:6808:1b0f:b0:3ba:30dc:56c8 with SMTP id bx15-20020a0568081b0f00b003ba30dc56c8mr10586621oib.37.1702911265027;
        Mon, 18 Dec 2023 06:54:25 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b23-20020aca1b17000000b003a8560a9d34sm4804643oib.25.2023.12.18.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:54:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: axi-spi-engine: fix struct member doc warnings
Date: Mon, 18 Dec 2023 08:53:45 -0600
Message-ID: <20231218145348.339470-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The build bots are complaining that the members of struct
spi_engine_message_state are not described. This adds the
proper @name: syntax to the comments to fix this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312182101.QOWovo29-lkp@intel.com/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 58280dd1c901..9ace259d2d29 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -85,25 +85,25 @@ struct spi_engine_program {
  * struct spi_engine_message_state - SPI engine per-message state
  */
 struct spi_engine_message_state {
-	/** Instructions for executing this message. */
+	/** @p: Instructions for executing this message. */
 	struct spi_engine_program *p;
-	/** Number of elements in cmd_buf array. */
+	/** @cmd_length: Number of elements in cmd_buf array. */
 	unsigned cmd_length;
-	/** Array of commands not yet written to CMD FIFO. */
+	/** @cmd_buf: Array of commands not yet written to CMD FIFO. */
 	const uint16_t *cmd_buf;
-	/** Next xfer with tx_buf not yet fully written to TX FIFO. */
+	/** @tx_xfer: Next xfer with tx_buf not yet fully written to TX FIFO. */
 	struct spi_transfer *tx_xfer;
-	/** Size of tx_buf in bytes. */
+	/** @tx_length: Size of tx_buf in bytes. */
 	unsigned int tx_length;
-	/** Bytes not yet written to TX FIFO. */
+	/** @tx_buf: Bytes not yet written to TX FIFO. */
 	const uint8_t *tx_buf;
-	/** Next xfer with rx_buf not yet fully written to RX FIFO. */
+	/** @rx_xfer: Next xfer with rx_buf not yet fully written to RX FIFO. */
 	struct spi_transfer *rx_xfer;
-	/** Size of tx_buf in bytes. */
+	/** @rx_length: Size of tx_buf in bytes. */
 	unsigned int rx_length;
-	/** Bytes not yet written to the RX FIFO. */
+	/** @rx_buf: Bytes not yet written to the RX FIFO. */
 	uint8_t *rx_buf;
-	/** ID to correlate SYNC interrupts with this message. */
+	/** @sync_id: ID to correlate SYNC interrupts with this message. */
 	u8 sync_id;
 };
 
-- 
2.43.0


