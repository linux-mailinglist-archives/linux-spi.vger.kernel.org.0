Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1513D2AD0
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhGVQ04 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 12:26:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51290 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhGVQ04 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jul 2021 12:26:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C66F0203E2;
        Thu, 22 Jul 2021 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626973649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=x3k96SXurbZA48P/lkQgfDs83i+1PSmUbdDIzs21Buk=;
        b=SbrGRviqO/5Rbp6K6cW4TA4BOuFqZUqU8rWIiMYYycR2iXits2kTms76YBo9n7WU47uvr1
        UDKv8X0LWrhcgnal7Cpi+aLnmtmuivyFnOrai2egjZ6a5anQYv1qQZiFtuEsuyDhx8Gd6W
        reD6EpOUpU3IocwbHjN8iG92uw47lNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626973649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=x3k96SXurbZA48P/lkQgfDs83i+1PSmUbdDIzs21Buk=;
        b=amAkSiUfcYAycWF5BcYuEPpJ/kUI4vnWa4L1wh1fSNqJJQJUKdD7cVsootjQyRsasadl2L
        SgFbzdwy2TvoxKCw==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id BF7E5ADCDC;
        Thu, 22 Jul 2021 17:07:29 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id B24D1445C89; Thu, 22 Jul 2021 19:07:29 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: update modalias_show after of_device_uevent_modalias
 support
X-Yow:  ..  Do you like ``TENDER VITTLES?''?
Date:   Thu, 22 Jul 2021 19:07:29 +0200
Message-ID: <mvmsg0646r2.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 3ce6c9e2617e ("spi: add of_device_uevent_modalias support") is
incomplete, as it didn't update the modalias_show function to generate the
of: modalias string if available.

Fixes: 3ce6c9e2617e ("spi: add of_device_uevent_modalias support")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 drivers/spi/spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c99181165321..e4dc593b1f32 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -58,6 +58,10 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 	const struct spi_device	*spi = to_spi_device(dev);
 	int len;
 
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
+	if (len != -ENODEV)
+		return len;
+
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
-- 
2.32.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
