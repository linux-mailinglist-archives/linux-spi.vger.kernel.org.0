Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404F422F6B4
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 19:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgG0Rcr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 13:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgG0Rcr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 13:32:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16122C061794;
        Mon, 27 Jul 2020 10:32:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w126so9283312pfw.8;
        Mon, 27 Jul 2020 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/oiTZvRbIGlVilYBQAce6xZVdmLxNzc+uCZkzk1V9g=;
        b=FHs7NZnjm1y+Y0yUChIknkWpkRZeJSCPECasUc1GMHAAX0gQC7gJAuExKfTQg7YxK1
         RUEDwI/yoCS6n/MAz2kzUyR1GEi8teb8fBWPR71NfQOMldeVOEruRq8ehJwY9KQsapzX
         VttbXvWYZpzHEXv3/AsCgnykZlqIkofJxNQRSl86UnfHYfHfCRpGD7QfBdOkCbCuc5/u
         +tODKkcQ1dt1Q9MPe6D5gxWZL+sf27Y1rKDqNS/HwIDAbmf/aVM8qctgzobo3bNaN9Pq
         DXAgXHVNMFUpmOkmRAZio1bmexKAlAfRo2vsRAcg5LU52jLv2Lri37SJq3juqcItZTqY
         /xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/oiTZvRbIGlVilYBQAce6xZVdmLxNzc+uCZkzk1V9g=;
        b=D6pkcIsP8QuInK/8j8YIQAVmdMcaSiKf4pm0SNROqFypP4ceJNn/oloABUBj29dB7H
         D8IAsOf5PEC+W0aeZ1HZadhkVAS5O+TnEIKORH+UofbzsTPbj9E4FMTUGgJz1pCSVtP2
         ct9Bd0p1qClOTYplRxMM7mEZOjOPvX1pud+W0gpZhhcxnnaJUjV4VQQX2nqZ3HeeHXyi
         NoIye4LeCiaoTV2TLOcjy+moMRJEJ5Y59+q/shZfK4lVNUDbNifiUpo2in/HnW9PM167
         Gh9II375z6X8nO3QSu2WQvzXrLsLnh9orP6uLqb1j3lAmt+IgD1LidD/4kjlONHHOEqL
         b5lQ==
X-Gm-Message-State: AOAM532VmM5tb/fiyspLc0qJkl6TTjEheMOLMnf7yrgEl4p/7WC731X7
        lEeww7Phd4ekxAeWRnTpRBY=
X-Google-Smtp-Source: ABdhPJyCn9FDNTlrAkhDjbasGUiicJEpzPdljaTQslwjMY8oofLHLGd1j2EDiVq6xsMqKuOfd5dCeA==
X-Received: by 2002:a65:620e:: with SMTP id d14mr20414491pgv.360.1595871166544;
        Mon, 27 Jul 2020 10:32:46 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id x66sm15427782pgb.12.2020.07.27.10.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:32:45 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3] spi: spi-topcliff-pch: drop call to wakeup-disable
Date:   Mon, 27 Jul 2020 22:59:37 +0530
Message-Id: <20200727172936.661567-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com>
References: <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Before generic upgrade, both .suspend() and .resume() were invoking
pci_enable_wake(pci_dev, PCI_D3hot, 0). Hence, disabling wakeup in both
states. (Normal trend is .suspend() enables and .resume() disables the
wakeup.)

This was ambiguous and may be buggy. Instead of replicating the legacy
behavior, drop the wakeup-disable call.

Fixes: f185bcc77980 ("spi: spi-topcliff-pch: use generic power management")
Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/spi/spi-topcliff-pch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 281a90f1b5d8..c73a03ddf5f3 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1648,8 +1648,6 @@ static int __maybe_unused pch_spi_resume(struct device *dev)
 
 	dev_dbg(dev, "%s ENTRY\n", __func__);
 
-	device_wakeup_disable(dev);
-
 	/* set suspend status to false */
 	pd_dev_save->board_dat->suspend_sts = false;
 
-- 
2.27.0

