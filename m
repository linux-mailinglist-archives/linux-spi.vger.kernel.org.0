Return-Path: <linux-spi+bounces-1106-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CB84BD99
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 19:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D25D1F289D3
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63725134D7;
	Tue,  6 Feb 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1WyFZOs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684913AE3
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245976; cv=none; b=WQT+IzouqFoVijkeDU4/Uf5wB8k1OTQZQRvJsUULzlDgUWs8XAFcmn+W+lTqxEK5xvsRE4mR9oHhSvMUocy1bWV0ut3i5tvOhHF6PGHT0AOs7SQCuWas6F/H/Re5HKMj/ghZ/G/yawKZxmHOp5SGk4zOGwMLO4cnNmPJLc2q688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245976; c=relaxed/simple;
	bh=aLHZaY3f/D1Cvwl5sgubAm6FRwgULOVFSORPetRPHK8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Ime0QazXZuFw1WYkT5dnAQEXsfY8SYgHg91SoUiAs/omq2CRTfSqPs4hRoo/SLoCbaN3uWhp0WEJ+WgxCBWGOBy8QPD73ZzJfm0T0T6mlGCq84Jy9PvsO0s/AOesMDZ8p6izSEBY73GqQs8FI5pCWEmJhSCh+SoipIpD5C/9Xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1WyFZOs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fd280421aso29681485e9.3
        for <linux-spi@vger.kernel.org>; Tue, 06 Feb 2024 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707245973; x=1707850773; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f3gbaFeG34dx/k1JXEXYOF1aOcrWpQjQ2m8JRALR5Q4=;
        b=X1WyFZOswRt3brM9Z6BheKezNDno7CJZTaTGSFSjQMGKTvEq/rNVgRsb4hStuzFdeE
         k3bvPWKjc8zoVymr20BCyTaBsduSVLUwvp7FNMh4uKL+qNwHf0cTK+U93XsRsAHoNx8g
         Xz/x1iCC0Wa+YSB3iwqO67VtX+8djVlyqHyAdqXBj4VKgAGfeOu788HkA4FdVwt7PvLC
         sEICbjMKuHhHTFJUDbgNSlL3jNma4UiPtinYb7fvEe7Vw6N0VbCLe2JuKuPE1egyY7ce
         wK7XA69367PTgD1fj4Adi0YW7OWShwcOsTrqYIGhokYooGg7hOCkkFdUGNNqHwCtk+T7
         bNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245973; x=1707850773;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3gbaFeG34dx/k1JXEXYOF1aOcrWpQjQ2m8JRALR5Q4=;
        b=LLvozMvB8wwjwuz4Eb43Ot8jYal/Ymq2U+DQaTOny4nfRzXCRrs0+Vd0q5GZGndyFZ
         bVtbACzABCmNd7GY+fMJT5Gxgt5kbT7ORUK6OVahujEsiDBKnMn8QffGT0FUHbWYKY+e
         ZOiUwbixfEEbM+H2Xd9+SkU8Cturf/VLCWY+htOPdtciBLDDLMow0Y4yS3fkha8xMnMl
         ggelvpx9kJDji3/Qn+xgkJOfmr/TNiEeWv3sSJzYtR0MQkT8I0Bkzkt0qGZYFDtXfeLX
         kCacECqFB4bPFkaPt+qNCaKLtCmoSBI1zJ+CQVbjlSDnjdZhRvIdAjzyZuogZA83O34D
         o3tA==
X-Gm-Message-State: AOJu0YyfDYaFwoGCSRF+WRP6wrbFg9Q235sHMXJXP2ambqEe/eOVRxgU
	3OnmAmsOau6pAkzAMQ1SS2X9YSk8HHH0miLVsGiDBWL9bllwg6Tc
X-Google-Smtp-Source: AGHT+IGjyJpReJlXQZHMtlVyXdgMKogJUQ/BP/QmKU23VA66h2yQDfah2LRyqyYRaaqqhz4GE+RtGA==
X-Received: by 2002:a05:600c:310d:b0:40f:b164:a415 with SMTP id g13-20020a05600c310d00b0040fb164a415mr2525524wmo.25.1707245972548;
        Tue, 06 Feb 2024 10:59:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4ZXaKQHXTvVaROMnQSyZ9Qlyfd0wQJrP4BzgrfQzq2gwfPBz/TBIJkZgsRf1fwbHZBIg+icPTXbM+47F85kItMG/d1Ffs4A3D3rXdfJvhEVRX5ABqSw==
Received: from [192.168.0.9] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b0040efc268713sm2837868wmp.26.2024.02.06.10.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:59:32 -0800 (PST)
Message-ID: <c518235ce0ccc878726fd1d97d0e56070ed89103.camel@gmail.com>
Subject: Regression on max controller CS lines
From: Luis de Arquer <ldearquer@gmail.com>
To: amit.kumar-mahapatra@amd.com, broonie@kernel.org, linux@roeck-us.net
Cc: linux-spi@vger.kernel.org
Date: Tue, 06 Feb 2024 19:59:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

After commit 4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b "spi: Add multi-cs me=
mories support in SPI core":

The code parsing device tree for a spi device seems to impose a limit on th=
e number of cs lines for the *controller*.
From the commit:

@@ -2295,14 +2385,53 @@ static int of_spi_parse_dt(struct spi_controller *c=
tlr, struct spi_device *spi,
        return 0;
    }
=20
+   if (ctlr->num_chipselect > SPI_CS_CNT_MAX) {
+       dev_err(&ctlr->dev, "No. of CS is more than max. no. of supported C=
S\n");
+       return -EINVAL;
+   }
+

(Note that, if I am not wrong, of_spi_parse_dt() is parsing the device tree=
 for the device, not the controller)

Why limiting ctlr->num_chipselect to SPI_CS_CNT_MAX (4)? And why do the che=
ck here (if any, do it in spi_register_controller()) ? If I understand corr=
ectly, SPI_CS_CNT_MAX is the maximum number of cs
lines on the spi peripheral using parallel mode, but that should not imply =
a restriction on the controller itself.

I have seen this has been discussed already[1], but rather than increasing =
SPI_CS_CNT_MAX, isn't it better to remove this check altogether?

(I ended up here because I am using a board with 12 CS gpio lines, and this=
 change broke it)

[1] https://lore.kernel.org/all/d3c93c4c-3754-480c-84c2-9455ec8af702@roeck-=
us.net/

Luis

