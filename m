Return-Path: <linux-spi+bounces-11980-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666C4CC7539
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 12:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8317B3060F11
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5C433C1A2;
	Wed, 17 Dec 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNnqs2JC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8A33B969
	for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966322; cv=none; b=CKR7FUgxxKrjMUOyPEU9GlrIEtMx/s6UnkHLHAAy+/fjgLh7JYPXEx4XNrwKxaPY2d4P3jQgXR0X++SAdQXRarMfUlfoCOJfveQW4sLeu26EaokxUFviPBte30L+4VCMe9mJN6kwFrSNjwuuapM8z+OtCpaCRsrLuvna/iNYPzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966322; c=relaxed/simple;
	bh=TmUYZB8WjESDVweOp5hzlAfaWP1RU/QdK0bqBK+51BI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoxuTi/xjEcRcgpMpetIepvWMzu8pnMOwTQAmaRj/61396KeCK7dSJeEqdv9aJFUtNxB+wWyfcLnyl9wgWkgNTapW2E1Lklb5g5iW6qt7Ci1Uxn4n/K8bh8qlVSo19jA62IYR+3EifUgOfvZGQFxw7oyBiyN4I7sSMWSHLopDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YNnqs2JC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a09d981507so3515305ad.1
        for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 02:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1765966316; x=1766571116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K04ow0eNGFdOpSpME/SmZeUSWAE32cTHhjE42HTO9TQ=;
        b=YNnqs2JC7Z2mbTUrpQZqxpTXfsFsO+r3K9RE/OM6XnqNf3Y6EVfYsdryCRk8pEQKpR
         hHYt7N7tamX/GudQeP8AleaDNsW7YrbuxoIS1PNqZdxciSxsU7lDQjS7XobuO9cl5/rK
         EhvBxxxkEOoV8afQLUs8BQk95Jt3KLeLVCvI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765966316; x=1766571116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K04ow0eNGFdOpSpME/SmZeUSWAE32cTHhjE42HTO9TQ=;
        b=rs/BkHuiIBzlJ2F3hTzh5ei2bq2X93HofuN3YP0reivuaKOfzuGdR5cum78uvyturq
         sbgj+nSV2q6N/bwY4CbRhMytwS1QIHFVjb5qHeOdlVG6kGkBQoo3LJcorAIruKxUkx00
         TKg0HzF5dtMSVO8PTuQOhhmdur8AGWVa//+0unn20I+mEmy7PNCoOPEiAIyJukoHWzwa
         xhuCwmUJ9Eacgl+Hn5NUk7D9EpW6q97wb10VWUBzwQbPrYNkHRGnaRyPooZcZz6AM5KT
         7CyFn7aEfAbiMiYcgztUYmuYFVsuWB7eR7gh+s3N8jkn6zUZPDW2fyQxpljhxq0DRgNS
         SsvA==
X-Forwarded-Encrypted: i=1; AJvYcCUsEFAOBnqkIvPtHXIxLN0uhgB6uLgW0+8ccQ9uN1yA1wotBWv/U/vgH2qkXrM3lvaHqEPibeXhoAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVy3Cxbdz3qfmxcxIWJPGBBrVCepfsTre1bG5JyFsfJWEkZfR
	0hesjHIO0F3luZjtJXzfMB8nRdgGUCCTzi79PWWBi7DcRlmu976lqEeUuKzd88+ONQ==
X-Gm-Gg: AY/fxX7zqd1iqfnUA1TT7H+c/Xb8uHjr0G7i+s9TvzWGtI+OYHER8msVkyqXs6jkl3+
	SX0DGpwsaiqhIxfPhXk+suEeJn01h1BbjbM1l1xA5d7/VpzmDd/shNBosWV8lfx4ar6WZpXnPk9
	Evo+lr46zct9j2pcjSfFoURCh0gyY0jsP3uZVc+hPtdhI2RtkJcIWMBw2p/2fV/hgs2mJYIVtxi
	Je/arqrmsCmFcQKjvGirZXWhQ9OPSx1k07K3XqwT/yvb3Za7rhYx6hKDEx8VMBh8ygawS2gFBLU
	nf4PYUbbcoVMruMD1ArwuqcLmZK7hWqCE8zbU4V274EfD+MTbjl92BI3jXZllyPqvNNgkp2Clhn
	6NzgmIxKNp1dUe/5lVPwGyEVGrgybRkJz1C+fOgFO+GoyRBl6f66c+9AhiZxscnpJGjmUu4od/M
	kcDk/3dV3J5mHZi4XpoEerokzTkwKt9J+NnZyfOmONvRHn5girT3JF7Wali8XsJSrfmNdH
X-Google-Smtp-Source: AGHT+IH9JDk9/8ttnmED8uX+Mmzi2jbUa2ALm/TceQ9Kmj2oqUNGhg7IR2LAST5VvPsW7hnAHuK+Yg==
X-Received: by 2002:a17:902:ea0f:b0:2a0:9238:881d with SMTP id d9443c01a7336-2a092388d07mr158621885ad.15.1765966316255;
        Wed, 17 Dec 2025 02:11:56 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2a00:79e0:201d:8:6cf9:c1ec:793:b8d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0cf143804sm102912045ad.73.2025.12.17.02.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:11:55 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: mt65xx: Use IRQF_ONESHOT with threaded IRQ
Date: Wed, 17 Dec 2025 18:10:47 +0800
Message-ID: <20251217101131.1975131-1-fshao@chromium.org>
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver is migrated to use threaded IRQ since commit 5972eb05ca32
("spi: spi-mt65xx: Use threaded interrupt for non-SPIMEM transfer"), and
we almost always want to disable the interrupt line to avoid excess
interrupts while the threaded handler is processing SPI transfer.
Use IRQF_ONESHOT for that purpose.

In practice, we see MediaTek devices show SPI transfer timeout errors
when communicating with ChromeOS EC in certain scenarios, and with
IRQF_ONESHOT, the issue goes away.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/spi/spi-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 4b40985af1ea..90e5813cfdc3 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1320,7 +1320,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, irq, mtk_spi_interrupt,
 					mtk_spi_interrupt_thread,
-					IRQF_TRIGGER_NONE, dev_name(dev), host);
+					IRQF_ONESHOT, dev_name(dev), host);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register irq\n");
 
-- 
2.52.0.305.g3fc767764a-goog


