Return-Path: <linux-spi+bounces-1034-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD4849ABD
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DB5284453
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303322C18E;
	Mon,  5 Feb 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ooErDcYy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CAB21379
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137127; cv=none; b=QS0zQy1sxVDMiFdbpzuRpxv/wmZuIv293hPjbw5Mfi/aLEQKpC5BOTMuuIwMRuXWOGll8rhh6tR8t8LkqlSEXEcEHyyqCFQNkIFid6m8FZbVAaZQn0i6hCvkGpFJ1/fxDs5jqadmdLh6BjkIS46q01wb1Df25p9w3ZHDmvLEDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137127; c=relaxed/simple;
	bh=0FQexx2CtUCxavZKSr/J2p/ydSe/rTCGVQ4ypBgxYlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8YiFVy9bKZAEbPTygvFcB0IrOpXnZ4hwG57odlc7ZtYGynXgmnlB0b3a6ENDoN+YVcDD/RqOrbDv/DTpC7BnSJtDcby5WedoidngrMuHLSquVCumCYYqaR+WitPSs7gDcRpW32XOF5jlD/UEIDI73YN1cenE/597yP6iy85I7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ooErDcYy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b189ae5e8so2247824f8f.2
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 04:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137123; x=1707741923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qx5Z9yzI7/GsBIXv5d4Hndyborn/ItKWNP+WpKBQHQ=;
        b=ooErDcYyS+T3P04nrNz40IadKc817CYzIWkaaXXvNQmrTYfvw/5Ow9s+d+ot24ADHo
         xq8xWUwWUoLhfoTUbk2uVITfVeLi3RUNphnBKNOMUtRuTzS2iDzZWbY/HGvla8V3FCco
         vnBY6oXMzKkNMkFbtfxzVjZaJuo3MnCdHaeovS2f5tDRZCewH2gGCLNT7abyPVnVRy25
         sMJvANx+NeG8gEFopXB8pn/QKkNLQlV91NLY7iMmWbcGSfhQVhotQgTnDVrPgb8R6BlY
         ovh2Emx1ifW1wutsi78AvFEqzoRw+RoGfiwZ+K3pXxW71Oc0dsABBlzFYP5leYJ7KvUQ
         g+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137123; x=1707741923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qx5Z9yzI7/GsBIXv5d4Hndyborn/ItKWNP+WpKBQHQ=;
        b=Yf0M/G9aul5glo2LeyQEMS/L3kWURdII3uDhB9jd/FlxZoL0rvnyDeP9ZDTM/zHBMN
         WFUaSG4wfeeUtgPa2Y5pN6ZM6PyyjMI0vA6E3uSDsdXSslys42YLQKUqkSSu1AtgT8c0
         DovbJ48dgtR+sjKH52DjwtqzlAWq+3ehGQCMXpCx/xuHjQ8gddvSzoig+LKmdTWcufMD
         iu59oCKIqOAC6qmlNFHMSbi3O+O2Enj3TyANY3dqpLlyRITx48jJqvaT65oAojhQpDWx
         4AOAVz/LGxPopbPPb1LiNUGgT1a429zj5+2svNW1OqarYd0hc4yZAkGq4wFXzxEPfm1I
         eXag==
X-Gm-Message-State: AOJu0YwPfrdW1OkJDgtupfa/RmeW13zUNrCaslKvHDGD+/DMziHqQomP
	YjrAKm5xiDWU6c1EvMyqY6Pmp5d/BsDntuvYVQ6hKoNDwDLO/lHW7VSrBhLRDOY=
X-Google-Smtp-Source: AGHT+IENb5/+ooWzL3wKqSyw6CoPegzi2HvBdBv0v42N94vmcjqi0ERz9OUD0oC6LoHzUuwF08Ctew==
X-Received: by 2002:adf:eb87:0:b0:33a:e76e:8b5c with SMTP id t7-20020adfeb87000000b0033ae76e8b5cmr8704510wrn.33.1707137123500;
        Mon, 05 Feb 2024 04:45:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXNyTz4l/uM3TNton705PQDnlbNrHzvQdIFoejDWZAaXz/PhUGIrVzx3X3u8Z6k7b5yAy2ikEcTLKhvJ2bwsyKAb+V6tWslcNkzaah0b0f4QIBD8FuFWARi8zqXG4RjvAltC+1j8ps0uo4Y3rDq0U4Bx9vKyPAcQolk9o4EmqMQgcyNBFBu8ThEi2IMmvcoc0oXr2zdvuezf9naLI2GxY1uH0GI44nB4TTtATOB1yKx0kLN3bcg5FTgG1nXHc+OgzVpVcgm/jLpsiE4oM1SkYfN2CRLpC+NoBUWFGi/bGYnQhiZ3BpIWrlj5QHb1LTZnomSGYmBoUaxklUvjmCPC/dEXbzUwFbLiYExkOHKyR2MtnHxHC2RQuToh1glcAKITUvDwzY0zO6NZn80VxOIDoj9pljSJ0VYjmuPUI3Eb+Tbu487QVGZDBOg4jzk5GQgFeycEXIpzsWBaSrt9kFGzfhR06VFEqPItaiR5iLwQLUAk2+9kqOmaTcto1lqiA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:22 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 07/16] spi: s3c64xx: remove else after return
Date: Mon,  5 Feb 2024 12:45:04 +0000
Message-ID: <20240205124513.447875-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Else case is not needed after a return, remove it.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 807270ec3c8a..3139a703f942 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -407,12 +407,10 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
-	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
+	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
 		return xfer->len > FIFO_DEPTH(sdd);
-	} else {
-		return false;
-	}
 
+	return false;
 }
 
 static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-- 
2.43.0.594.gd9cf4e227d-goog


