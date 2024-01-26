Return-Path: <linux-spi+bounces-857-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D29F83DFBB
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E47E1C22BAF
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5831EB45;
	Fri, 26 Jan 2024 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2+25mnh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2B22339
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289364; cv=none; b=YlmJ/Eca9m2KlKdxsRVisfZBM/KJ0r9SIdc22A/SM45XLbh4GiKWIuPYo755Z8UhErUcdzkRyIS53+4E/RZAJvT/tjmCS5Uf11G1JBkQqQhBi93qaCAkQHY0uOrQhtVqWdY/VvuDUbDhjAE6+YPQMdDIYuozxeh5isXwFWXEE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289364; c=relaxed/simple;
	bh=6rOo14Bz2JZpKcqmwTvyP3kn0DgWf85cl4VWFDXDtLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4FJWfSDMteWwLKkUJPSAJrr6Rf2KW7dQFh5FtT27XWgjlAqBc0ynXJizcAE53A6YcmMrF6CrsEl779EgUjiH2CI54Ne/MrAotbjo0RDhShvzR9bUPYkMXeqKZ+a+CItIgXY/Ls+jJTatKas7ffmiXa0LKkOm13X/e/17q8Kxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B2+25mnh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso11019145e9.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289361; x=1706894161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFdCZ+E7BFUbmZ2dzvoSTWD6D1fnBZ2RDi/MQ7bu2EU=;
        b=B2+25mnhwv7LvnXiDtp4U/HAV0Dt3LrvYKzqx+d+SKrCpWNP1PxINi/nopRPBfSeIz
         /MDGp7EZZ0+Fr/hfXV3v/2LVlTriaOj7Vjxkkj/ojXxPVyaI1QmtuI8dyNgsgDxVbHlt
         F0BTN83SRmDWbgDvcNJiYrHdrIKnisV4uwdSRBE091wjyJYNLyuFOQ/CBh2s/X6srAHE
         KggJs+eR7JdaPjN37WYp+lH3ildPhOtLFuh2cfwsNDbvQrLeZBK3RxLk94oLHicjBBkj
         mwEx5w2YlE58VTAi0u7h0/a0rr41XN7gpDFjIa+lg0zwLa3OS0VMvzIPBPuWRCTsYwTW
         B1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289361; x=1706894161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFdCZ+E7BFUbmZ2dzvoSTWD6D1fnBZ2RDi/MQ7bu2EU=;
        b=Vc9Q7iesPHpje9DCu5R/e3SF9pwKmZsv49RDNd/78xDG7DWUuB0l80sOLZ5Hpfhser
         qvWlGYnYwOJ0Z9rTMxA8Tlt4wxQjrn/vEw/pNsjOb5nvT/y6kvnb6xMUjQOh82CHt54N
         X00egegRPykseMkXGfy+XRdhCHIzSvXG/pYeDGTVAU3tkNVlkciUmP2ET+CQD9pO90lC
         jklvzlkNmIG1BMXrVnXObQ4ShLcdfZWokX+Ki8NVRixwnFH/7edr9xZNSaTXv4agKkL6
         4WMtM9b9mFt36XmJmcb1iLzuSLSTovMCWkxfDmoJYjYqcDJqfUXU/QY2YFVeWGsA7Yb4
         QH5g==
X-Gm-Message-State: AOJu0Yy10ccM8iSNtoaZqmgxdjtIduWnXZCPtTfZ02r9FkAZ3pHL0ZrO
	ILrKupwHPbtzavb6mb3p7HRJ8J7HzIjaBXKTGeUy1rxyNfHwPAYI61XNOlOXsWw=
X-Google-Smtp-Source: AGHT+IHAdoE7ZY9wf1qj3d+JD3BcLNSbHlFCODLChuw3+wfJAwKowp+5DxpzG8f1Cx3S5gdIKHCLrQ==
X-Received: by 2002:a05:600c:3ca7:b0:40e:62b1:58a5 with SMTP id bg39-20020a05600c3ca700b0040e62b158a5mr90288wmb.15.1706289361429;
        Fri, 26 Jan 2024 09:16:01 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:00 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 10/17] spi: s3c64xx: propagate the dma_submit_error() error code
Date: Fri, 26 Jan 2024 17:15:38 +0000
Message-ID: <20240126171546.1233172-11-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
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
index 6268790bbcff..64daf944b245 100644
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
2.43.0.429.g432eaa2c6b-goog


