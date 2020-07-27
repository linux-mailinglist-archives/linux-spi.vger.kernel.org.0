Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9652D22ED10
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 15:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgG0NVI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0NVH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 09:21:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE868C061794;
        Mon, 27 Jul 2020 06:21:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z188so1212247pfc.6;
        Mon, 27 Jul 2020 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCrFxpLw5jwB0ZWba+VhbgCI7p4GpK2jg/E4s1AB/yM=;
        b=IO7Asnw1x5jaHrPrBYcTWUlGNNMyYH8tet7FkILH4HmzUn9u+meMUVh7296Xg4Rcrw
         26mjFiFrtobGZP6/JQgzxcGK4uQo2Ig3wmk7+u7qj0oChgvGHJ5G9KhIY810qGt9ivDU
         ecmte3moVCfdGcTryICQuGadpX09WZv7fo/TBHNX0iVyai2I1ajQfLVDjDziQuCVg66d
         Op9jGMYmfwrIRYRcsmdDWYl1LEML4CLEJmejHa22x3gGRBecWBIPddPw5Uv7QAQUHlzf
         sAX2Uzq+xrcpElEoZ7YiGfd1t7G8ipJ6UnABh/A6XbzkyEMxuz72nuyz0qykT0qrGyq2
         K9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCrFxpLw5jwB0ZWba+VhbgCI7p4GpK2jg/E4s1AB/yM=;
        b=Xd1ssR79aJre2Ww0osYOzXlelshgca/9fMVXEWWC3fwiOCQcFWnVdSho8zgX4SNdMo
         kiGcK37dTNPOr70byjQB/UYcjKOk9uPvh3edL4k5tNo9sTFFZBbMDkiNMQn8cgP7yDWZ
         +ZNekGaTwksWb+Nh/IXfyitVZ5K1E/JPlHIxPzwfqvXhPbVcA9JJ9X8t+bras7stp59H
         hPDrxLCLixYRAx1Iv6ps/n7Q7BGvfTExqmEvNe7V4Ujcs+hwhRixGv5mcijjhHKf57x7
         /j9/x5qOa/VeSKitKooncazySmr5wGtMMowtGsb8trJjJMMRZ9Fn3AanG2rCxXhlS3OR
         QpXQ==
X-Gm-Message-State: AOAM5302EW+m3eEXkU/4/YB+RjFxiqcH6Au6Bac1kqkzI0K47DDACO+m
        WDnRueyKhnL9QelWKXOAH8k=
X-Google-Smtp-Source: ABdhPJxRloIPWLVUZ2/SuwNrfH74RWEzbhOzbwrdKU/RikSvAOSrIk2YgZzbcFwz0HqrECq6wOxFhQ==
X-Received: by 2002:a63:5a20:: with SMTP id o32mr20002948pgb.15.1595856064511;
        Mon, 27 Jul 2020 06:21:04 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id my16sm12206087pjb.43.2020.07.27.06.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:21:03 -0700 (PDT)
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
Subject: [PATCH v2] spi: spi-topcliff-pch: drop call to wakeup-disable
Date:   Mon, 27 Jul 2020 18:47:43 +0530
Message-Id: <20200727131742.82289-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
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

Fix: f185bcc77980("spi: spi-topcliff-pch: use generic power management")
Reported by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

