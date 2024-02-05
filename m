Return-Path: <linux-spi+bounces-1038-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9AB849AC9
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905161C2096C
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E342D638;
	Mon,  5 Feb 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpHrPGT5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30291BC58
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137132; cv=none; b=WOuF50QAmERIlSQH23Juai70tSdJf11XpusV/qUBCLTFxCItTkq1NqVOj7Mtm/Sxuk9+hEWzl8afUCdb6TuZMGrog9R3QQUDeIkjCQo7M1waN6S/tfD34a7Hi4b3/xkR6sm4Xxjwe5t2AGcQCFAiicudQR8ZA6CW2QLfimW/hV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137132; c=relaxed/simple;
	bh=bjmGyFjFxiqioAr4g1XSOAGWrQhhKSgwyKFYExhglLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8YArw7AVpjbkdca1S+j8dBaOyhk+6qVFRpeRVihjtZU9J92Jn+ByktsfOJEDweY0DME9Lu4Z+ZesZ/sVNimDjUrvC+NCipkwOrURaVScIVxhf+jhxa7a20/ZtaycKwHQtjhrPaXW0/+6D5WBgUj6re3CG8Nb56XR/3AwaYrur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpHrPGT5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b123f99d6so2869828f8f.2
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 04:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137127; x=1707741927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtonYnG1zvMSmP8RYe4qSrpkG7WWpwfs2mfkmLGPi30=;
        b=mpHrPGT5UJr0ovdh46vE30EcjQcYYa3XvWTOxkNGyHjPL7eDiaZmO03fDC0wBoBgC3
         YJB03qV/99kbTQxc36QqNypUXjXmNoKQAdPhW5k0c+mwbUU98ixUV6nkc4yDSJSQysbD
         CNZwg7tdkP1eolshfqIU9GrwsQOU+Wimqs79/a3gMdPw4XWQt+b+Lf1vIJshb1IbLTAs
         PwWWBgkfHTo1WkBn8IRnSq2R5HYnvdDJPAgxIgYw1PvJXCVi0CUImtnC/LqZEqaecXN2
         I/2h/c1JxSRDUDXRg8YUW54MqFYGxwkwXDV6CLDf/dMnij77NCcLt7SERVtNnCfFiSJd
         fCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137127; x=1707741927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtonYnG1zvMSmP8RYe4qSrpkG7WWpwfs2mfkmLGPi30=;
        b=gRMseJMY0vydQvbG/utoF/zPIm0DeP1XEB0KOF+VkeUvUkqu1VNNg3GeruWGNZG/XM
         dmme5Ihc3MZhEbBf5nfMnn6t6t7CUJgx0rBgm9U3uXnRXPSNagu0SgG/eZo9v3Haead3
         3ytIdhJf5f1gSfdhXFyX+keUev+1pMBJyStSlfQ35ClV6mi9syLTpGMXuLBDXL3im/G+
         kXV3HG8NurQRGMvBBbyjPH2a/DeTo0bYMK/EQvkS/ZCqjR8bKXozGWIli42PEOF+u2D5
         hSKLooeX1yrvBkPyLDgrRowGn3kTAL94HJ7+x8aIRbyZ6O9DeA1yLIcsqIQKq738Ne6Y
         zqnQ==
X-Gm-Message-State: AOJu0YxzHkInM9f6wl8pDTxo2yEjCo1tnZTvPmNOLPG/Ht3A1yWFNgiS
	tiFnkxq3WbWVW4FqA8lTJEmJCTaW1qtWnHxYrj0pAEGISKsqP6bNvbK8jthFdZ8=
X-Google-Smtp-Source: AGHT+IGvOiXo7HPcAuCueUfCXl+hW1dHjHJs0oFybOPNePVj78Eq7mqkrITmY1dHKEpvtlR/onCLSA==
X-Received: by 2002:a5d:628e:0:b0:33b:1494:e4cd with SMTP id k14-20020a5d628e000000b0033b1494e4cdmr8738260wru.3.1707137126957;
        Mon, 05 Feb 2024 04:45:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUnB2TnwxP2m+P+k2osg80LUiFMk8AYW9KKJixyKCil1SFvymbNwDnyv5aGOLjkdFIIat4WmSO7a4JXLHXn3VISSvM+7RVQcg0Pc0Fb9CO2WjD9q2jAPVAk+Y81aHewTEE1IiAUbWO2KdsWTh+EVlqaA26G3INEN+MW5DD//ZHCIBgpkDe+Q1yXqKZwi7+TZV6oZgWxpLWtlnC/vbOnnxR5hsTMrwcDUDdAcOhChiLGv2Cy+Fee/HbCH/Faz0FVfeE/fIgfQU1IizkzZZUkIk8biLIW2rCUJFI6sj/09hijvYqXudHO+D77AWOHBK8Jgy5aZtvLBRys53v9c3/ru4AGJtK+iGd5tYVFx0GPzDwqTGRYDcIPSQkBIOWaeLWHB0eNBql9MhxloRoKEj+AwfvCosH7A5tKS0fuUekbdm/MbC19l3fiGQbqdyjkJ62nOFmMU5HkynyBAYQUxajpBYqcz0FL95kIBqlij49YqJmlZcSsEDOd9WIc6DBH3g==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:26 -0800 (PST)
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
Subject: [PATCH v4 10/16] spi: s3c64xx: propagate the dma_submit_error() error code
Date: Mon,  5 Feb 2024 12:45:07 +0000
Message-ID: <20240205124513.447875-11-tudor.ambarus@linaro.org>
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

DMA submit should just add the dma descriptor to a queue, without firing
it. EIO is misleading and hides what happens in DMA. Propagate the
dma_submit_error() error code, don't overwrite it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 43b9792988b6..7a37f5d0abd9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -321,7 +321,7 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	ret = dma_submit_error(dma->cookie);
 	if (ret) {
 		dev_err(&sdd->pdev->dev, "DMA submission failed");
-		return -EIO;
+		return ret;
 	}
 
 	dma_async_issue_pending(dma->ch);
-- 
2.43.0.594.gd9cf4e227d-goog


