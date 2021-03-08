Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8582733116C
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhCHO4O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 09:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhCHOzl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 09:55:41 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD073C06174A
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 06:55:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id e19so20972199ejt.3
        for <linux-spi@vger.kernel.org>; Mon, 08 Mar 2021 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLj7Gp4AXNBIRfM05Fb/npNKmdzGnIj+j8T+QIUmIp0=;
        b=GYwAt5N11Htctvk5vaStUU1oMV8AcHJat8k+JeWcUlAP6NIzKfpP2octcY7sipgk3Q
         q2JbUqobc5/wdXMc3ss58YGJM1/dfaYyxxVtxbzbXRmGPABKNLCY4f8p9dE17XRZWR4P
         G4eWbUvaydrHkOhcAKITzQ4XatIdcCRogDyorfkg9j9xZPTLwSBwVpPrx36/8lCWs64y
         AmnbbHYZYZRjlVXrAFO8UFbyNEm3nAGU280MlSxCdKPqrVn6TGqZM6/tk9WeB3xyULdp
         duSPWwZG4Bs2YEcTeTv9hOjWQC+g8vtDuFJLHkEArTfM+f7c3u1IiTVgSOgSM1mvqH1E
         MAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLj7Gp4AXNBIRfM05Fb/npNKmdzGnIj+j8T+QIUmIp0=;
        b=Kl9gJN9FC+ibK/h9fhblFtY+C6Cj4HVKvhuX6WHkcvE0O2dPf16RPL1iK8gx8/ooFi
         AJLdrIplv2YchdOzVMEARx9KfgW+LulPR1zjvNDxJp+/r9nO6tW0Nn4EEVqtXl6V0mxn
         CkZyNlezw5pxxroqtcCLyKrQM0pVJ95nd/XRctPLgMggu7JN9u7R5nzVwbZ7HRuKD4xV
         PxrprtB1g4xJGSnjjbKuhynSUCtByibgflbP6zBj43Ts4GHBn1RkAr/c1XFLAyEnclD6
         vso4FJDyq8HoeOvUOBL25sGbFlzRJnR1TnfwZMwUjDrC/1O5RPvQwcO1L5jnkdSbDSwj
         L/hg==
X-Gm-Message-State: AOAM530zPKAssjuh0ZprRFJl4HY7CwHT0e0haTMMfeuDobejtRV6RyeM
        42hRj9sOwSFCW64RU5AMIIXAnjbduZ1oIysn
X-Google-Smtp-Source: ABdhPJwujoxKBULC2TiDF0uTmZ725nCMJDdNLnOASHbIowxRxu7/T7o0BEees1GbdUH3W536CdvnxQ==
X-Received: by 2002:a17:906:2804:: with SMTP id r4mr15241523ejc.521.1615215339299;
        Mon, 08 Mar 2021 06:55:39 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:38 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 10/10] spi: docs: update info about 'delay_usecs'
Date:   Mon,  8 Mar 2021 16:55:02 +0200
Message-Id: <20210308145502.1075689-11-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'delay_usecs' field is no longer present on the spi_transfer struct.
This change updates the doc to mention the usage of the (relatively) new
'delay' field.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 Documentation/spi/spi-summary.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index f1daffe10d78..d4239025461d 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -411,8 +411,11 @@ any more such messages.
         duplex (one pointer is NULL) transfers;
 
       + optionally defining short delays after transfers ... using
-        the spi_transfer.delay_usecs setting (this delay can be the
-        only protocol effect, if the buffer length is zero);
+        the spi_transfer.delay.value setting (this delay can be the
+        only protocol effect, if the buffer length is zero) ...
+        when specifying this delay the default spi_transfer.delay.unit
+        is microseconds, however this can be adjusted to clock cycles
+        or nanoseconds if needed;
 
       + whether the chipselect becomes inactive after a transfer and
         any delay ... by using the spi_transfer.cs_change flag;
-- 
2.29.2

