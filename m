Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A874C1EAD1A
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbgFASmo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 14:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731433AbgFASmn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jun 2020 14:42:43 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3807EC03E97C
        for <linux-spi@vger.kernel.org>; Mon,  1 Jun 2020 11:22:49 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id h7so1609816ooc.9
        for <linux-spi@vger.kernel.org>; Mon, 01 Jun 2020 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Qg3FAVPbW0weNZsCa0qtJe2eNAuBqsHQnnBFxoGLg78=;
        b=ZfNdUye7sXOcsD41SZJU4liPaQJdpNRAttpGRjtuXgVyjKmvqs7W01mdTaA1yQe2FM
         y/FfOq/wIELUtRekVtrY63Gz+alL0vfo/lFC5rsQssNizLD9o8hxWSm5emMar/3qwE51
         8ZZz88SrLTJd+MIbC19az++NZqFx3JYAyYEHrIhrRt0IdBYyUzdM2aVNl79R7AqgyQ6m
         Oh9m433U1jZnW2D/vLrtJ6FFTCA57xwPxvh7Lnvj0g7qCLYgLczuiuu6C36AVxTSB3kv
         ZFtmbK2WLrXjxkI7H4zX4KDKUtV7a2uPQViCuj13Lrro4AaDjb09P614n0fko4MjyAsc
         vFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Qg3FAVPbW0weNZsCa0qtJe2eNAuBqsHQnnBFxoGLg78=;
        b=RILARYV+tl9RDqxjwqza6kDAbwhUmVNkaCYTEbxGbsaypjvMQiZu9ifLqaqVRJWcKu
         0MpX8sCHe6SIquHUfo4jfLwebJkSxllzYyHV7qF8q6o23yZktBAIRZxPRbeCV07yoMFW
         xHBP+Fo6UcOb3R94gf58RGp7hoc2Xn1PCzaKb0S68/GYPb8PeZlADDHycklUVLNGPdxv
         w5QCM6OgEce0KhskHvYnZRWAVOYqO55r4Ok+MoWoOTymPixYUklxhsnH3JCk4YTF/ODH
         iwqalzRM7b6k4pyQ9hEkI5XZmzbHCQ3vb6cBiSJdhCNq+o4GaCPq/ZryNTam9hTXCSd6
         5Eow==
X-Gm-Message-State: AOAM531PAmybU2ThD8aRX6GXyviPgCXQ5DTQWQLhkOGktye3ZqKziP31
        JnZxZ9l8nZqs+s+nXh4UI20j3EM=
X-Google-Smtp-Source: ABdhPJx+RIiQ3ANHLJkEVdYV/hk9WlAyU9C7mi4sFCrFt7Q5T+xTxkJ1YcZdwX3F/4qZr5ZufeYxgA==
X-Received: by 2002:a4a:9442:: with SMTP id j2mr17907728ooi.37.1591035768369;
        Mon, 01 Jun 2020 11:22:48 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id t24sm5339234otp.69.2020.06.01.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:22:47 -0700 (PDT)
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:5946:4e5:448a:387b])
        by serve.minyard.net (Postfix) with ESMTPA id C8055180044;
        Mon,  1 Jun 2020 18:22:46 +0000 (UTC)
From:   minyard@acm.org
To:     Han Xu <han.xu@nxp.com>, linux-spi@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] spi:fsl-espi: Ignore spurious interrupts
Date:   Mon,  1 Jun 2020 13:22:41 -0500
Message-Id: <20200601182241.9272-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

If a interrupt comes in for the device and nothing is waiting, it will
crash the system.  Avoid the crash.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
I was working on a system where the firmware seemed to leave the SPI
device in a state where an interrupt was pending.  As soon as interrupts
were enabled the system would crash.

It seems that the interrupt handler will crash if an interrupt comes in
and nothing is pending.  This seems like a bad idea; this patch adds
checking to make sure something is pending before trying to process it.

 drivers/spi/spi-fsl-espi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index e60581283a24..091f0c681ff6 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -217,6 +217,9 @@ static void fsl_espi_fill_tx_fifo(struct fsl_espi *espi, u32 events)
 	unsigned int tx_left;
 	const void *tx_buf;
 
+	if (!espi->tx_t) /* In case we get a spurious interrupt. */
+		return;
+
 	/* if events is zero transfer has not started and tx fifo is empty */
 	tx_fifo_avail = events ? SPIE_TXCNT(events) :  FSL_ESPI_FIFO_SIZE;
 start:
@@ -274,6 +277,8 @@ static void fsl_espi_read_rx_fifo(struct fsl_espi *espi, u32 events)
 	unsigned int rx_left;
 	void *rx_buf;
 
+	if (!rx_fifo_avail) /* In case we get a spurious interrupt. */
+		return;
 start:
 	rx_left = espi->rx_t->len - espi->rx_pos;
 	rx_buf = espi->rx_t->rx_buf;
-- 
2.17.1

