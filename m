Return-Path: <linux-spi+bounces-9105-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BD4B069B2
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 01:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE46E7B621C
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 23:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5314F2D6606;
	Tue, 15 Jul 2025 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlgdwIIJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FAC2D0C7B
	for <linux-spi@vger.kernel.org>; Tue, 15 Jul 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620504; cv=none; b=EfTVPtU9k3oynX/e2fPJPeC+unxHOwdAPlvGhksnfk2248KkJWy8b3jvpUWw+n3Q6prz6IHaXw9vnSBLpb+SViVk9aRUOL4vpToQgrSKhvLav/4aLc4VeltuJy56/eH6b7sChfvXUjbQRHKPAvCD+jxNdNq6ej+XcJY+fz5gQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620504; c=relaxed/simple;
	bh=hQBUKhXoZhnrg3aw/tvNsOjzOzq2grhpIyy5kdu/2c0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L2GdjBpRjylK0tNRsozyQ/EUZA+TDoQHfGfvDpPX9TyC7BfdKUpPIpDYNJO/FlerbYGObAe0f5hA5Oh34O1sGuqVTI50Wax3a5AnJNou+mvqq9iGAhMipfXOuFr9MofrhyORAgfKlBjspFTh2wEJ6cHsZtLJ9RqcD4VurkuKEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlgdwIIJ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73e58d5108dso735294a34.3
        for <linux-spi@vger.kernel.org>; Tue, 15 Jul 2025 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620501; x=1753225301; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46gEt3Bx0FBkn/nnSaRTnSsikfa6dw7cUtJIKu/AHuc=;
        b=ZlgdwIIJ011E895kg2zptBdrs9U43kLvRAKy6PQKD1kWhY/iaGFFzEVUfrgwhUuApL
         trsdjGVCzlThPDvGOid/rCR9SjvfM98yZLoBqsp8xmyYDh5BqRg2vJVM9rM1eTih6Fw5
         PTNh7K9Z3L+Ir4n/cVXUXudf9KGJ4OtuBkB3suVO9/yoVbmVq0Qpp8za1ocHAYNtNs15
         PPY7ZR9e9k6Fs0jIAcfnA1UZjCsUSGGpH2nnY2qb/TgGlo6ezjLF/WtprGJ2p0Y5KuqM
         tB4c3O6XSHww39/wRLV0pskukIycGfh4kqQnhIWVqKwabYuXU23xw4bM3Skr57uu1pEi
         MXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620501; x=1753225301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46gEt3Bx0FBkn/nnSaRTnSsikfa6dw7cUtJIKu/AHuc=;
        b=VzeysQ8BJ6iyqUaoPU2Eaf7ExPsis+nyQ9HPeepRVeaVQJMWklheqVAt5WUT/cxRjK
         CIfUdLxmod7k5QuGQSUma3mkXgUOYpujulefn9kRtf9jq6y9jBAAxW0IMpZgYpaF5Gz4
         K0JZhg7KVOa+MpGZSlYlJQn+jNlzYyspduLxUW/4HmodMir+IeehNCs76PO2EJmpesIP
         cGZyTHym1Ewp8QXoaoRG51nI1uFBAE8+EQLuVf+gZHOmm9qHLtUYwomIk1okpp+YCySL
         ZKAKq4CwGKG/5RxeEj98tyOSTxpGe1aU69P0WzfOxhISM3GwZbRQwuQFcPLu0ObuymL/
         GPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdmVWuBXbTTvapY9VfHsZPIiFkprg6Ac7QQ0PJk6S7T1Uo8ODT3VIn7zvAqiYNXy6ciTh4DaaOZqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHear1M5a9Tym8vL4OfGadtXeJ4+RuFoKBylThpMHd/xUB7TVa
	VQ25b5ElxV49oJ+olen15FXxocmczHO+tr+RRFQyY2cgA0Eb9gJrT8iVXnyw2OFH0r4=
X-Gm-Gg: ASbGncv0RD7ipYY7v6MllyzFlYoPW+ZOj/pnayyBUDyPsiMUFOjTQTO4JlIC/Lsaf3K
	+mZInJAexKE0j3mBny5li0Ya1PFrZ/4PFFXJgwnmHgkVRmi0RKPKnWsCveuE03dUJu0FDC7xPI6
	cE53MPJ5JsKXFF6BoCxrlx5LroMIo/9egk4M4L/82D3fZZLEeNtHT05VOKMTUPH/qf2/cgyzWEq
	vrP+y3q1CJPkFwQ0WdJ5y6he56Qq6V9uKXCUSYsxcHexsWkDG0GeYrCgmRRASb7TLnVBt95/1UU
	OQK5LiQV2x96M+br3k5FQwcSu/FWoEobAf0J7OlKRkxFrTY3POlKyW2EveWJB+1mSKrdR+noFLB
	LLICGTwwbPalVGl5gJLqAI+kcZgi0ad+GG2X+fQE=
X-Google-Smtp-Source: AGHT+IFrIo3qo3Xq7DrVRugRg16jg4aCYHopevdB0f55AiC+g1RwMciM6Lgy4L9vDkABRNtjnbIHXQ==
X-Received: by 2002:a05:6808:30a2:b0:409:f8e:7272 with SMTP id 5614622812f47-41cf0cb0f3cmr543563b6e.38.1752620501381;
        Tue, 15 Jul 2025 16:01:41 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41c73a25f04sm457282b6e.0.2025.07.15.16.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:01:40 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:01:39 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: stm32-ospi: Fix NULL vs IS_ERR() bug in
 stm32_ospi_get_resources()
Message-ID: <fb2a26a2-119b-4b5a-8d44-b29e2c736081@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code was changed from using devm_ioremap() which returns NULL to
using devm_ioremap_resource() which returns error pointers.  Update
the error checking to match.

Fixes: defe01abfb7f ("spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region"")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-stm32-ospi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 72baa402a2c3..f36fd36da269 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -823,9 +823,9 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 	if (!ret) {
 		ospi->mm_size = resource_size(res);
 		ospi->mm_base = devm_ioremap_resource(dev, res);
-		if (!ospi->mm_base) {
+		if (IS_ERR(ospi->mm_base)) {
 			dev_err(dev, "unable to map memory region: %pR\n", res);
-			ret = -ENOMEM;
+			ret = PTR_ERR(ospi->mm_base);
 			goto err_dma;
 		}
 
-- 
2.47.2


