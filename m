Return-Path: <linux-spi+bounces-3705-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F4D91DEDE
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5357C1F21D85
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 12:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49114A4F3;
	Mon,  1 Jul 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuycOaDJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92060BBE;
	Mon,  1 Jul 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836092; cv=none; b=tG9TfrlU1eLjkocNti+zwf9ZP0nSr7u0jgFaZX2HN/ORYDBpd7vYeeZq6n1h5GZt8GZvZFFQ8+/UEjkJIaE/NhAyVR2sf92a09OTtJEfiVZq4dWtObSzVGrmSXnV0GyWvBLMxkIbHjjLWcznJLjkjpGUGLioq9uXmNlktoS71X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836092; c=relaxed/simple;
	bh=nZXNiezCVx0aOESi8wBAJNvQek+wMZFidNfa4VKpwtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7JGYeTAizm+KKQ2ON0+U3DhmOeYBKwcDIr3CpExydHgy8Hnh0c/08PduYSnWNDON3hGSSvRLOpgJimAPdHmT/2hKZycTj2HiABiNDdmmcxnaEIcK0Jjh2Sh3UTxWeAp8TZDw4M/mBRu1WlhsSExvMUmpGma+PoDJrCNC2ixp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuycOaDJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-706b53ee183so2620532b3a.1;
        Mon, 01 Jul 2024 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719836090; x=1720440890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS386Usr4IoaIpluIYt7tWvHO4kvCI/g3TOu2sRYrgA=;
        b=NuycOaDJqd5w7shLOy0r3fQqAVlkoTImAeujHMNVXivEURPi8saVZUcdKYAPthB7yx
         TkXox4xQMoDd9UW2DEc7TwRdb/9/vyqNFHSGAIvQwRxf77jZ+PXxaLVHckjll12sSTSb
         VOcm3oNuVFtdbM+GC2JhDdffIdMbH5hozFzGVlXcHuZRd+0ATxjVSvWcJEZxs+QgDrtt
         mb5zbWMCoy+AxjFR2wRJ0TtiE5Z6CJ0kbKmwr76Yo6zCHekO6bbGzBHj1uJJZpxvfp50
         gA+uaVMdEG/CVua6ZFTRbajHaO+7yY+Jg2NEVQO9f5GOwkMaHPc9mjezCWvnF3ZuUtHQ
         k8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836090; x=1720440890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rS386Usr4IoaIpluIYt7tWvHO4kvCI/g3TOu2sRYrgA=;
        b=xMRrPvGfD2y5W0nge6jT7PKoSXpa5mwIH2wcZEKqZrcofijsCbNzIMuSnEOAnQe6bM
         y538YIIRlAunknmg1hL7mNUjwbNGVaTQQAKpMc79r7vemK53uKJOQSoezMy6mYuwjjVa
         HzVxBvoJEwMpi+okYdMGvVoEZk6iz7iFTZxE4HnF1v4+RazXQ3+IJ8OBstl6iKpqF2yf
         Cs9DZNhIbJlZUgciZYNgZQQk39q303TSsoF/tJvnolfNZD/kes59H6UIcSiot3jlXRv5
         Ha8fXhLLEf2ECFq5friRXyOG07kqeJplFDgt+kyeMkE8DpzPNxASgXZBPZfsEtjqHUCu
         eqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWNGTqGQ9v5QwPCJiAdvA5sQWBEoKsEDeNHEccsgM+XmSkfLSqJoWv2xTtARCpmDY9fmIsQ1tFv4bj0psc0NH6fXb2juz9LrcFYMB5cbVULcYV3yVnvNNOciGrkZuowCvrXH8SPmbuHyBSiDMFUtB5SH9oTu3NTnluF6SdzMBlVKJQWA==
X-Gm-Message-State: AOJu0YxhW/awELtMA9h0NT2a61XRBneWW1o1ZQ5vIUn5a68o41QsvjsN
	io7azGQx7/B9KXb5u2AaLn4Zm+6FgxcsuEKI5xakc2j6i3fzS10nwwc3FS1V
X-Google-Smtp-Source: AGHT+IFNbabduMp8p2WkQI1bgHf8jszIWFXwxeyq2VyRo2CV/F66u8aNQnHpb3lwQVkcK28BW/LDAQ==
X-Received: by 2002:a17:90b:180c:b0:2c8:2cd1:881b with SMTP id 98e67ed59e1d1-2c92815591amr13089443a91.20.1719836090204;
        Mon, 01 Jul 2024 05:14:50 -0700 (PDT)
Received: from ga401ii.. ([223.178.83.109])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a77sm6613098a91.6.2024.07.01.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:14:49 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/3] spi: dw-mmio: update dw_spi_mmio_of_match struct with thead
Date: Mon,  1 Jul 2024 17:43:53 +0530
Message-ID: <20240701121355.262259-4-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701121355.262259-2-kanakshilledar@gmail.com>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

updated the struct of_device_id dw_spi_mmio_of_match to include
the updated compatible value for TH1520 SoC ("thead,th1520-spi")
to initialize with dw_spi_pssi_init().

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
Changes in v2:
- Separated from a single patch file.
---
 drivers/spi/spi-dw-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 819907e332c4..39e3d46ebf5d 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -419,6 +419,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
+	{ .compatible = "thead,th1520-spi", .data = dw_spi_pssi_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.45.2


