Return-Path: <linux-spi+bounces-6792-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C077A32F4A
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 20:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDCB3A7872
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E1E261396;
	Wed, 12 Feb 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1OdSolp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44E260A4E;
	Wed, 12 Feb 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387581; cv=none; b=gCErc5nKlMTVVfbmE6O00nsFJrdTq+6j7tNYKMGmRMnw+zJx7x0BTwGuZgbGNYwrgndgXkFSs11PpiFMF13rOSF7D+C2DleneotDR/0ILs/IL01wol27FbYcqtcb2D0opI0QeWzD8CjG2nKrmY4yIoQMw/IqGkC9X93qJkj6lpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387581; c=relaxed/simple;
	bh=3cDWoSwBQOyNLtotcBMDIyPVqfoM25U3lFmXWIfhTHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZxI+4J0O0BfRRxJR3bYnujlf2BSoHouQR8mmX0I8N8dAbKPpnQlvjp/ssRcBq/qNoC2ljQTxFXxiUZDqqpAc+57nbLRpoO/tfAKTQWhZZ1dv2XfzkCg1NtlrAXR6+P4o1KZCEvu0M+Q522d4V1U3QDPyhYSLocmahw6f+4vUqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1OdSolp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f7f03d7c0so83995ad.3;
        Wed, 12 Feb 2025 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739387579; x=1739992379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOqaSz1QymNVqvSoXI2MUMGj2cHYyqzoo6sZSnsPqGQ=;
        b=j1OdSolpPNE13DVjbA2uMtDF00tnzUQ5iYVUkmopklaqeS0DTjb9F+fCZ1tAjdUilB
         kBq2TrRkbq5z6XvZjVkPROr4M/G5phbrw+y0DHdexpl0MOUxLW4qktGumJDMAtdEqgN8
         pEHhnu2qowgKDyQL4BdMtwvcyL2BBuG5PH8j2/KMaEybXMqZqB6Kgprs2d3U75MtoVmE
         3UTg2mUBI0VzBsoWxe3l9Q1pZbF4WE+xOI4FUWnkP23f/V2fqDGIsxPCA8EjqUgwWE7n
         hdFq3R8fPFkgPEp+53Yvj1JLaUd4KOTek3RDrZeyATfY/0IaoCW3GMnr8KFJ/RVxZzJf
         OjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387579; x=1739992379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOqaSz1QymNVqvSoXI2MUMGj2cHYyqzoo6sZSnsPqGQ=;
        b=lIWf2thhu5TMkGURHQrB3/qNa7VGRHmagV+5zOnAIm2EIcpFAUG4Kw77KNK7xt2XFG
         V/A+mMcxW0hENyEZ7ig9iHpilJRHdMIO9sxD7KEUv4wGVWZtMDJybALevIOdkKXhU68h
         6R9KgNyBQFvn32XVu8o3ISLL8j8/vhAQO6F/aRKJRU8Her8hu0j61547jmSuBPmFskCz
         FurjmeAel6tPQi8bzTko4v/NCWSGuaLpP3OegJPHe9RYz7bL8FCXb3ft7tyAjKiUV+A6
         coti+vASvZihor6dwhVFtoLtZJzjE0bCN2Po6gcIK8wvJagd6/520vKYTYgrwYrX4qIW
         ZeDw==
X-Forwarded-Encrypted: i=1; AJvYcCVfp0JAAY4i15zUmLpbuu7L1csW0yngav+PtX0lcvgU+0JmECSXcyxnhB3L9QXzYmLukvYwUGPj3v7sUCdpPXqLxeY=@vger.kernel.org, AJvYcCW1Jf4s5r0lF+j6i9hWiYmJpARgrLeTtWhY2LBuTTA3m6SRPmBDeDE4fPP5yDEQCkCS7bnKYErxE678@vger.kernel.org, AJvYcCWN7S/jgCR3x7eut9sO4dYkdg3S7s1Aas2iSmAOvIKj9Pj5dHqbtriANcykfIvZ43YrBJPME/WmgiE41SIk@vger.kernel.org, AJvYcCWmMAKVkeDF2BwLiMqLmM1PXAFvuvC1bdXidF+7E3VTrb7XHnonD1x4f9gXhTnXtJy5DOZ97dRSuM6o@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4pkFcGNkRcygbcGJWoqTeA8BusMqBLRKxWBD5BnpkfRpXH6pL
	6NwZy7CxGRPRqrYi2KR9KG76SK2zExRE91pBXexJBW/6/28bhIAb5OnnwuWl
X-Gm-Gg: ASbGnctC1gZlMvmtxBJjqwAB9iNdnQ1x9D8aGiH8L+dW5mAwE3DBaAzFE/NeuNgUdKK
	pfRxCQcwRom2pg3lKKCzHrArecTlf4OtpkuzGFq4dGJWLdGUZEA/VfWSqV3BfcPdgn3rrVrWW9Q
	rCi7wmyF+kBCzAqJEQhsVlf+LVZrgzzpnuRifLl3LyD4qOjN0BT4dz+2/qC3EuESQa0JxHx/j2W
	5YcY8BYx6BiZ0QWafACJO8DqhptmiaZju2Al2XzcIGw4MLI21yPKbEIEEgW3do1rLjwBfBlsYci
	XJSTRb2iVxMSJtOnzoZuOUCuOlJTKFNt0ZdTSSA2jE/pVtB9E3fcRn7nnQdPWdiMOtmsIUv1iS2
	TIg==
X-Google-Smtp-Source: AGHT+IGicZoPXxTU+S/YqxVcCZyaJIpp3N0yw2wFvTf/7eomyrPkUvq5yeOuzReT4CyOnDWYxlOxSg==
X-Received: by 2002:a05:6a00:1709:b0:730:99cb:7c2f with SMTP id d2e1a72fcca58-7322c383fb3mr6100608b3a.6.1739387578796;
        Wed, 12 Feb 2025 11:12:58 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f79sm11536944b3a.77.2025.02.12.11.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:12:58 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	peter.griffin@linaro.org,
	andre.draszik@linaro.org,
	tudor.ambarus@linaro.org,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v1 0/2] spi: s3c64xx: add support for samsung,exynos990-spi
Date: Wed, 12 Feb 2025 19:12:39 +0000
Message-Id: <20250212191241.280-1-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Exynos990 SPI controller shares similarities with
the GS101 (Google Tensor) SPI implementation,
but introduces specific hardware requirements such as
32-bit register access and variable FIFO depths depending on
the SPI node where it will have to be specified in DT (Device Tree).

Denzeel Oliva (2):
  spi: dt-bindings: samsung: add samsung,exynos990-spi compatible
  spi: s3c64xx: add support exynos990-spi to new port config data

 .../devicetree/bindings/spi/samsung,spi.yaml    |  1 +
 drivers/spi/spi-s3c64xx.c                       | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.48.1


