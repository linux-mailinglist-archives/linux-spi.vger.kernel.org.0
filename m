Return-Path: <linux-spi+bounces-9333-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBFEB1FA77
	for <lists+linux-spi@lfdr.de>; Sun, 10 Aug 2025 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9014E1774CE
	for <lists+linux-spi@lfdr.de>; Sun, 10 Aug 2025 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F22246BB4;
	Sun, 10 Aug 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcBP8Tyd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7142E3702;
	Sun, 10 Aug 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836759; cv=none; b=lT/gBLK4ZdGOcSiKYjnQM3BE0rgq+d5ltnSwz/fOxrxLNevEDhbSCtmzuIHvAgKq9/5SQ/vI77D8u4y9zPbANP+zPajDdThapRBKwwLZAYs9okOjovmc/jKcva7YK98fSNbUaFFxH8MkD8NI9oxY0t0OISVoGa0ZLKHPOjFlraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836759; c=relaxed/simple;
	bh=FNoqUch8OPFjVbWGpCfpeu0nQlDh/hVUd5lcIkBWk20=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SpKrpVLH3Jkl8d+JJ/bdjodV62UmDiQIgpMBtsIo/yy+sZ03cBLfwlLi7bXdJ7xjAsaHW/LIRPiOikaI7t1XkYPRDqFeW84x5fCHa0KGAY/64btsnbXJ9zhO4m/H4KLjNiwTT7VIRYeYmJCxEY+41UAL7LrEcXfNFGDjkDs9gNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcBP8Tyd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78310b296so1861534f8f.2;
        Sun, 10 Aug 2025 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754836756; x=1755441556; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoY0CPX3Mp6Pye3EdbyOcGWTEgfX2frxQgeHIT5DyZ0=;
        b=QcBP8TydGAbsRz4XozL2WzJFBobujh8trv2K6DDdoDntZtk8qKj+/pwdZ3Keb9R4GC
         hqeSKDDha2RQm3mSNMhLypyO4n4rc66hsHOMj06LElgw0m9shxgWWH0MuKdddJNKqBRE
         /XW2xTlvtRXS0+QoFIhEtKAxTX7hUZBE/AcUyXOhOqzBXEI+AxxAgMFRSUE6Hyi5n8qX
         zB4i/jmiGtfg+2JNKHk+xoNwA4sn2pi/7LyivjHrOi4OYFngm1bOiiZukreOBPy3jHWZ
         o82Gk6pdVL07R0K7u8M3wALOrLnyKfwmmIAbaLQOZHCclhLGOBpGZfcST3BNTq9SGLL6
         LkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754836756; x=1755441556;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoY0CPX3Mp6Pye3EdbyOcGWTEgfX2frxQgeHIT5DyZ0=;
        b=HtrbCETkh69vFdqU3BNvq40AyAfdtZ3V5g0rUh3bZzp++x/N45BUzMrIsY+yFPz2hD
         LYrZZ6Bv7Zu8lssCbVMUsDHtO3qQhEXZJV74BMhr0sfH+Bs3Hv6y5vtr7JozUrpu+UPN
         yPQznkMkoEjiDoCkq0DNjs6eaQbEMhcjRoDz7tlfN6dg/SMm0Cc71gjO9PnkDQOHhH5t
         yFiq1++ifBHE37hGhcYqvhUs+7SGJzMVF5C3PS8bKvaGI1GV4tfxTE1u8/DOhVZl9IDH
         sJJW8aNeXLIt+hZc1+jCRjSR3rFJXTTW33XKaGCJzoX09Cghioo72aB9YxAxyNKMeeyc
         Jldg==
X-Forwarded-Encrypted: i=1; AJvYcCUvpBBkwdI2zUnN776Ve7L55j1zyxL9UWNHy76Nzr9qQd6U2EiXNXzuBGEw0j5+Ia5ZkBKH4QUbUgngZlS7@vger.kernel.org, AJvYcCVULClzfnN2SLu1xvgOUX0pAHoQCXQtvhwQlpCPMyL8Xg6p2E++jxnuftyc6CT+ZlYa44kJHwcQxHnBNYIC@vger.kernel.org, AJvYcCVcr4Fi3/bYkhvbttk7MlPN0DVdXuC7kePEZnl8Mr/vMUEySBZ7dvFdbro+/i8mYmzCpn+g+u1B09B/@vger.kernel.org
X-Gm-Message-State: AOJu0YwICA0KT4OnI50UVKjCgo6AgoWJt4gAX788eJzZN/OrFKB4qVDW
	jgzhTz9JBl/DWWw9z4tza2856wDwfP5Seu+Z0F28ehblzOn2hpH/H1toYIgFDA==
X-Gm-Gg: ASbGncsxElGVxAuiyKo8O11PQ3HYzgrqqMO8OPsWFFOIamSWKq2lzzoUxNeEEXUdgc3
	G6zfIc98ELj9EHfMxnySvd+HK6fEpntACx+5QYyLHuNGue/N8U8BGx6bvrzq9adNehTXjc/S0Rq
	a0HYpTk5E5mXuetA8/NavPKBIxTLgsLfaKsLqXUvG2EJvwOjoxEMVj2qsxDEVPSksaJdrHiZQ/t
	DEKapqufPM5bIDZyEFbBSeVyqWwK5br/5gJKF6YW8VMQxYCCDGdl1euOzStd4tfkXIwSVCWJgX3
	yUMlxY+5oCmGSRmOH4JAwKxYmJElyDuxEgJ8HFFF8bxvAVQUR7gGa394JLaWNLuw3tP6yvYeza8
	9EaeUY2R6R/23ME9Xq4FrtDtLi67LW6PJUajpcZ5R2AcE5AX6t3o=
X-Google-Smtp-Source: AGHT+IFhoUBteOIXdLbP6G3nDlH8fThEqymPt+BorrfMt3eobqFuWPiyuio+qlb4fl+hAUyIoDRqhA==
X-Received: by 2002:a05:6000:2388:b0:3b7:9ae1:eb9 with SMTP id ffacd0b85a97d-3b900b2dbe2mr8626495f8f.23.1754836755948;
        Sun, 10 Aug 2025 07:39:15 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm287721715e9.2.2025.08.10.07.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 07:39:15 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/2] spi: spi-qpic-snand: cleanup 'qpic_ecc' structure
Date: Sun, 10 Aug 2025 16:38:49 +0200
Message-Id: <20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmumGgC/x3MQQqDMBBG4avIrDsQNYJ6lVJKmPy2AzKmCS0F8
 e4Gd+/bvJ0KsqLQ3OyU8dOim1W0t4bkHewF1lhNnesGN7qJP0mFiwWLVz4hwrIi2Dex+DguHn7
 C0FM9pIxF/9f9/jiOE01Wm1dtAAAA
X-Change-ID: 20250809-qpic-snand-qpic_ecc-cleanup-c4d8f4e49e53
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The series consist of two small patches to clean up the qpic_ecc structure
in the spi-qpic-snand driver. The first one removes an unused member from
the structure, whereas the second reduces code duplication and removes
another two members from the same.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (2):
      spi: spi-qpic-snand: remove unused 'dev' member of struct 'qpic_ecc'
      spi: spi-qpic-snand: remove 'clr*status' members of struct 'qpic_ecc'

 drivers/spi/spi-qpic-snand.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)
---
base-commit: 13d0fe84a214658254a7412b2b46ec1507dc51f0
change-id: 20250809-qpic-snand-qpic_ecc-cleanup-c4d8f4e49e53

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


