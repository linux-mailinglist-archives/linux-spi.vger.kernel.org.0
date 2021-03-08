Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5133115D
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 15:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhCHOzl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 09:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhCHOzf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 09:55:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49500C061760
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 06:55:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m9so15136276edd.5
        for <linux-spi@vger.kernel.org>; Mon, 08 Mar 2021 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Io9v2GBIlHI+Tmp+Muo2ozOuxnB5JlN/m/peVkSOoQk=;
        b=KN8oqTz03n4iXKtuJ5qi9J7eiFCSjzNROABDY6Gb/MplICzu3i5V03YptgmpTTumx9
         qzHGrgq8fs8JGet9Odv3isiqA2BAEwaSruGVQmS9a+mZpNXFpeE4VcGYKpq2SjITIXEr
         iZu8cMKqFXc0GNaf9S/tP3IfDJqMyEWVlwbxUYbisZoe8tFawpRpLzcdVzwhbtNF+qfh
         oh5qVIsYJBFymQreVC72K8pfrXlBDUp9vpAjjD5DhQNe9vKsYc0LarvZp9YPPAvTNQ6k
         bUkDxp4231M2aHh4lz1mTKmik9470JWb/d4AGTx8NT+lMZyzE4h4Q/QHCx3Q8heZ+6Wu
         Pn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Io9v2GBIlHI+Tmp+Muo2ozOuxnB5JlN/m/peVkSOoQk=;
        b=l5FwoVg0j6v3/HnTGLA4FUw5p7PXWmyhJntISb7kOfEhDWvEeyA1quiIdmFEWOT5rf
         c0RJrTaxENua6X+3RxChoqvy3hUy99ova+AzIkYSo35VT/bEeY2eMrHNZ5EGoDnGQWqa
         kM5KAHYUbPe+7PFvKOsYSKWNucvH21E1mzcOtLGHpqOcfgueXYdBTVgH+JxU5TzUVUNo
         w0c87gFr9jetD7HCD1K8UR3E6sfJ4uy1xZsmto6br99GoxRijN1IkGAXohu5/1MuevcA
         ekg42uP8yFcM2lmcOnUlvUsfRGWCMTIxcczMQZbNSh0BQ68uh8wY3QD2Zj3PcDZzJkH8
         hCig==
X-Gm-Message-State: AOAM5309YEKev0nPKOc/lmrWizgw6gdo4xik2C5Rl2zb5eakQE8zP9zA
        BdairIELvYIuyBeXoRJM0I44Las1sE7G8lxD
X-Google-Smtp-Source: ABdhPJzOxDsiKTJZFzssNH71mhV3dmH3qpwIBVJVNeEVFcuravA0h+m9Fy72NPjkwyy5NAtefvkZcw==
X-Received: by 2002:a05:6402:2076:: with SMTP id bd22mr22161922edb.378.1615215333831;
        Mon, 08 Mar 2021 06:55:33 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:33 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 06/10] staging: greybus: spilib: use 'spi_delay_to_ns' for getting xfer delay
Date:   Mon,  8 Mar 2021 16:54:58 +0200
Message-Id: <20210308145502.1075689-7-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The intent is the removal of the 'delay_usecs' field from the
spi_transfer struct, as there is a 'delay' field that does the same
thing.

The spi_delay_to_ns() can be used to get the transfer delay. It works by
using the 'delay_usecs' field first (if it is non-zero), and finally
uses the 'delay' field.

Since the 'delay_usecs' field is going away, this change makes use of the
spi_delay_to_ns() function. This also means dividing the return value of
the function by 1000, to convert it to microseconds.
To prevent any potential faults when converting to microseconds and since
the result of spi_delay_to_ns() is int, the delay is being computed in 32
bits and then clamped between 0 & U16_MAX.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/staging/greybus/spilib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
index 672d540d3365..30655153df6a 100644
--- a/drivers/staging/greybus/spilib.c
+++ b/drivers/staging/greybus/spilib.c
@@ -245,6 +245,7 @@ static struct gb_operation *gb_spi_operation_create(struct gb_spilib *spi,
 	/* Fill in the transfers array */
 	xfer = spi->first_xfer;
 	while (msg->state != GB_SPI_STATE_OP_DONE) {
+		int xfer_delay;
 		if (xfer == spi->last_xfer)
 			xfer_len = spi->last_xfer_size;
 		else
@@ -259,7 +260,9 @@ static struct gb_operation *gb_spi_operation_create(struct gb_spilib *spi,
 
 		gb_xfer->speed_hz = cpu_to_le32(xfer->speed_hz);
 		gb_xfer->len = cpu_to_le32(xfer_len);
-		gb_xfer->delay_usecs = cpu_to_le16(xfer->delay_usecs);
+		xfer_delay = spi_delay_to_ns(&xfer->delay, xfer) / 1000;
+		xfer_delay = clamp_t(u16, xfer_delay, 0, U16_MAX);
+		gb_xfer->delay_usecs = cpu_to_le16(xfer_delay);
 		gb_xfer->cs_change = xfer->cs_change;
 		gb_xfer->bits_per_word = xfer->bits_per_word;
 
-- 
2.29.2

