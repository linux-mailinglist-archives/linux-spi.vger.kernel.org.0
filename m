Return-Path: <linux-spi+bounces-7509-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA6A83A04
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 08:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABD819E4B81
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CFF185B72;
	Thu, 10 Apr 2025 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emXCgN8k"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CEC20487F
	for <linux-spi@vger.kernel.org>; Thu, 10 Apr 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268203; cv=none; b=p5h9aQWNTVAxSkXnGJ33YQZOt11SIAj0dven2g+x7Uq37v8gbmKKsIPhCDLcHcSPnCVvwd7wfsX3/6VqKcAuSlV8A+sWrPzTtavGKcDIvEpx6mTxKkB80YmYRU6pSy0gFaGqg8Xkg9s2GDPU1uvJ3SDpvs9d4CwzzrUlUZHKjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268203; c=relaxed/simple;
	bh=YNMWPXST4GmkU82cqtCWweSG8CvPoxSqJXedn/pDLfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGVl6JqIw8b6kNuXeyw3Zm23/2Mz6v2OgbsxwairDOu9TXkbLr2kqdwuDx6h3eDzhqGJWpbLd90I/CDEh5gou6LymOl98HKezdIuZu+SPgX6B6jikrj+EJhijDPWVISup+rlL4aepbP9QwaFQG11a984B3nPTWAUjdoPpEsClqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emXCgN8k; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c559b3eb0bso23698785a.1
        for <linux-spi@vger.kernel.org>; Wed, 09 Apr 2025 23:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268201; x=1744873001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQNsJ3ZOiZBcYiwdRb4mVkjkRmdE4On94lqt+0SKelw=;
        b=emXCgN8kQMiWqNJZzV/NAMyCy/5Xwr1lEpgGsZ0DDppJUTAy908jP/l5ermTHPHO8o
         TclTg2b7ijvfqHg7A87UWdjGlHIUzsprljAg+ck4oWQhC+VaWtQcwbHyKlm3IhGPwBuP
         efwxOJos3Rqzxrs4F98AgundPnHBfdX8tDkX5lEED3ilDPRLHJ7p/zS9ybjIE+LD/YLk
         eP89HaHTw3iUyFPdp7RdAZj9YREAcFZ9SWe7Lxt45EzaiwUNZfrGTQAkrp9bsYp7xZJe
         HzgQLBopKCeFLTd0daCY9W5cFQ/VA3pimbz+4M/RnFUjZNbbH9TYRLz/X1FjIiaNn4fO
         Tdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268201; x=1744873001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQNsJ3ZOiZBcYiwdRb4mVkjkRmdE4On94lqt+0SKelw=;
        b=KVBOOSAJW4NhRbBRXTsvqel7Nf++M1GMi3dOmW0aaZXkjKg6tJzH4SwLM4sx8pTt0E
         FtENk90CjBSZT5ELXZEhTQQxcr4B2nEeim5AcKxfpMdgVwRZPxgne0gRfn32wyUVXazK
         8LZV/xfYeF92IZ2DGHdIno5+ePjrCEIKy3YeSTaix6BT0ns6xyf98xBS+IA9CzCqfP7X
         74s1Ox+VuuZQLJOrzqvY1kX9tdUKAIOs5nor2nV52G+qz/22aSysqVnYPt9stsXIiRnw
         KreXddrbkuFyNaK8T8OY1gYPHhvcqif9CFQOh3Pf75kgCHWpMabEOs/ffTRSfv4EWaYc
         VkJg==
X-Gm-Message-State: AOJu0YycaKgQzRC1jV+QXBXdKx/0M0teLItcb/3qLb+XibSeZWcgo9X3
	/5SadFqR2h/pntu93jXBopTEqpNAJ46zxaiwfjK94CVdwH11WRnm
X-Gm-Gg: ASbGnctzEtooYanCMWPCcnbFMFzjG0PJ/cB+78KwezXQHg+8EiuY/rIdKsRuHleXiwF
	a8sPZxuMoTgr9UIgz2KAPSGYZAvrM38Mrbzf1vppD8oiayTv1CJUfhowN4NYFrcMb0/NF5bfdN4
	U5MoH84Fjcdin3zCttQ811Wvvw3qGBA+2e7T26YIwAfNptCT+/1KBTwRcfxsH8ujXBUf5NhbSm7
	ssPcSYa9YMiv5YLhDtlTNr87gEAbTARCiqnrusrg+RjTbr/eWRJye5DnSpWekV2gi49icIqLBxS
	WxmJLMUS6W3ckLDT54L6guazVus/W0lql9o+y5nmqzwrmoy7nl4=
X-Google-Smtp-Source: AGHT+IH8Rh4oQxmbv52IflL2wfwTmNN62cTX1Kblk1rng58eaLwD7Uk6UckMElDU3x7WC4HYPwlgCg==
X-Received: by 2002:a05:620a:178c:b0:7c5:464b:6718 with SMTP id af79cd13be357-7c7a81c077fmr192043285a.54.1744268200969;
        Wed, 09 Apr 2025 23:56:40 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89515e4sm46547285a.26.2025.04.09.23.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:56:40 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 10 Apr 2025 14:56:10 +0800
Subject: [PATCH 2/3] spi: fsl-spi: Remove redundant probe error message
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-spi-v1-2-56e867cc19cf@gmail.com>
References: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
In-Reply-To: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 imx@lists.linux.dev
X-Mailer: b4 0.14.2

An error message is already emitted by the driver core function
call_driver_probe() when the driver probe fails. Therefore, this
redundant probe error message is removed.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/spi/spi-fsl-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 2f54dc09d11b1c56cfe57ceec8452fbb29322d3f..b5ecffcaf7955e2ec9bb3e2857f8bc14d73a2f90 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -963,7 +963,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 err_put_ctrl:
 	spi_controller_put(ctlr);
 
-	dev_err(dev, "Freescale QuadSPI probe failed\n");
 	return ret;
 }
 

-- 
2.49.0


