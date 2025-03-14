Return-Path: <linux-spi+bounces-7143-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47EA60E49
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 11:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136193A9B0F
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6097F1F30BB;
	Fri, 14 Mar 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFJTDqmC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A831F3BB5
	for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947011; cv=none; b=uxY8hJjDQZnwk1fHYYTPYUg4AW21zxODsS6/L5mia9Cw6Hw3G4qzw4/bnbdOlXiF2RvYMkHgBam84RasDqH90TP5GQd8B91zLulqgeWe8ZNl+hyZs8dR//gGz6h+JrkPLq7B5V5m/4CHpKQ1pqESUDUqYRjTALv07HD3rQ8b51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947011; c=relaxed/simple;
	bh=wgSkUJ1HIbbvgEalgmD7njvprBMNHLFJxss43b8eAV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JIdTsm4YhpoibiFdvA5U+Z7AN9lH+uLCqu3/QLn4IEQYsJ6+AMAZKXnL6eVrffhjZRusvAXX1TAdH9ednw2/K5k1Td/aYPJHCPaUHxfKdvhtFVV47rTmtMAbPEWLYk1FjneYyuI/4RZn9w7evEgHBWA7pXiAgjULIIE3q6XLQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lFJTDqmC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so18137925e9.1
        for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947008; x=1742551808; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajo3lszNKhNp84zfU1OoU5TqXF6za+pgykwrTQT7DR4=;
        b=lFJTDqmCfqvLlb4nRVhU+x1GzwDLofMklUuVRInzVm+QQkIm2WgvLyEJxAgNk8dItF
         w/33Z8gF/SBufSuf3bU1gsxmQTKad9TQj+EdJ7dnAlbzf/bSV1RM4wsD1f5KVU28yJsU
         I4OprPIav6LiiVozH+E9LrM7cT0ArgUAYWBotP+j/78TahKeta628GG9VMk78g2g3tpq
         QSJExr1y6jZgRfWTQPocPsg+Pjx3AV8v8t7iWtbbwC254iXhbx3U+p3dotrdy1TpVxgB
         jtUv/5mFOIXJx2ikSDwZ2fIGGCKgzIXuT/f0lqRPEdDsWbhOvCplnKOXu+OnK2Z6U8GC
         gOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947008; x=1742551808;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajo3lszNKhNp84zfU1OoU5TqXF6za+pgykwrTQT7DR4=;
        b=gXlqEPiUy4brVgygayrcyM/CriKJVSAzS0Ay5rwyacWF8+w2UGDJiJnldebcvMZ2yE
         tetcV/jvAJASC9PkLxlsy37pzVPtIGrzx9evi2c7OTg6XAEMv8bDd5GIXXtt/OZVZTCL
         hjW3PhUifA/Rap9bpJvYyDUY2PSp3s9i2r2Gi5Zf/zmqM8PKPjcFQ6oZaSO3bC6tIesl
         5mxSVyymx7QwBx9NmBPkC5S/M5l78K8tRXKMCTy6Fwxi4o6u7gKeg3wpSYOSL3djZ9Op
         9KfocqE6TOn9k7kPYiYO0jzoL4EMMcWC0i1xDQc7BcWXLoGqrq0k5i+6rLjEK3l0pcoW
         DwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSPuCNoyp3ifQ1CZp7gloAx8c47FhZjXfOUJPRSROAq8kMXd/FKkfea3OzGKWUqVmMgOYCT2lT9uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgCwyaDYtL6H+MTNIZ7DMaNuVDCPWur45fTjfYDqt3+jAYUjO
	X8Wu3bS66ut+Y9JA1ndq8gORqvJzChmOLlzo1kR3OouyR4xgBh1QAZ0wCM9KhtY=
X-Gm-Gg: ASbGnctIwTbUUyc6oYzF9wP1Q9UcoeCeIjVF+aZn3//M8+q5lsFMwNwWjBh6YqCQO73
	hD1QLEFlCAMXh9Vl50rze6WuJmjfL9nAgvkWA8hSW3Xa0y1ssHvmeFOT8rVYOJ6rKsHL7dE3PWa
	jh72QRI8i3g8LxfPAUULMAkx4IPL8UMCDb0g+zUGWTqDm58q+GFHdu5ILG2/y/5vdcloh+7N5g2
	Wgj6pmvkx2n4xzRzqAKRKR+Rc5MR/XbMaDKPh5bSFzJW/eEKtrLjzayhLBd7pBclk7AYWxPav+u
	/ASLb3sOtsX92Y2CRvvWqBZ+YYckALNWZVFrMNCZ/TL+x1WdkA==
X-Google-Smtp-Source: AGHT+IHbOkr5XakbV0xgM2f5fP4p0hwGNF7uGzjMIrr+H0pRM0Yj5sQU8IrthP6K42vBJedD8UbWtg==
X-Received: by 2002:a05:600c:4583:b0:439:86fb:7326 with SMTP id 5b1f17b1804b1-43d1ecd0ff4mr20249955e9.22.1741947007770;
        Fri, 14 Mar 2025 03:10:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe05ff4sm12439265e9.10.2025.03.14.03.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:10:07 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:10:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] spi: sg2044-nor: fix a couple static checker bugs
Message-ID: <79c71b81-73a9-407d-be6f-481da27180bc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here are two fixes for Smatch warnings.

Dan Carpenter (2):
  spi: sg2044-nor: fix signedness bug in sg2044_spifmc_write()
  spi: sg2044-nor: Fix uninitialized variable in probe

 drivers/spi/spi-sg2044-nor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.47.2


