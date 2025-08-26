Return-Path: <linux-spi+bounces-9670-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E6B3745E
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 23:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF06D3BAB98
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 21:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB928151E;
	Tue, 26 Aug 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOXxko+M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342AA2F9C2D;
	Tue, 26 Aug 2025 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243459; cv=none; b=QKkAD7PKfSdiXRyhcXTKcfNZw7JY4I0e3e8OspiVht0jTjLEIr5q+R77RY1fDk+UGpHrAdHYHeKJBRu1twxswLG6GcDcZV44uv+reeKDI3N1GaAoKdFhnn+EcpbZPCdeJcy0ft69o9RN5RRA1ICnEzZhECCct3VHatUz/DwoRwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243459; c=relaxed/simple;
	bh=FgAYgWymu3o/W7Kpeg65iStpBNbiEzboeZKdeyYXjYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bg5pE8Wmo3weLk6xScszNcYS+oqHAoJs/MdInAEhCwcSeRQpZJKr7lVBDY6f4Agz4K+GZDUUXpHhUeAWQlAuFHk00Jx3pqC8m32km3P2QgeXRt/UcvtJK9TglPPGzwEQjy4bK4MeZM0hbfNxTsofuiQaEineUObtMEdWL6g+QmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOXxko+M; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7f77c66f13bso4382685a.0;
        Tue, 26 Aug 2025 14:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756243457; x=1756848257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmM4t0aBKvOmEGg9Ac4ffzNoaugADk2GnwdUWPX0XUs=;
        b=QOXxko+MNKA3CeK1LZlnvGXdwH+3T+XGl7hH6YkM+lbi66BFcxhYbJyd3BZdSiPkt0
         qVN6bQpTYf0I37//UR3a9GjHKnShShFEqI0elodWULY/haulbsS1XCtYyF90tBnDLMx5
         k+8ksBAPpUR8n/hBLSnr/rlZaxyYgaLP0qVqHoskOxY4A2t++yJ0Pvei04exFCJsXNcU
         PXJscZWMbTjrms8SH9VXuJgFQ3SPqF/3MmInm4FKdxFkff/K7NUH1RmFkvXWfQ5gjisU
         U28+XMwZv3p5tOm0gzgc6eiIETBJYRuaucAYQuRjBaMjyRNUpYWEmijAY1ptUrprp0is
         K8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243457; x=1756848257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmM4t0aBKvOmEGg9Ac4ffzNoaugADk2GnwdUWPX0XUs=;
        b=TGg+AmpOugPDDu70zbTbxixQ4r3kwIMVcLcD25WH+Jc32R4OgIBo/LVPvvgmqsdY0B
         /Uyj/wqW7Y9/xvK4S0OziVr1SLJXO3EL4bFJxeDstVpWCmKqpa+HpWeqG+kAMzm+5voX
         A+9Z08uJXX99Sx+2kePl1O5S8SfcqCi3KY3JSfCp/91Eh2T1yriM5t+v9P2DCfr4Gp5Q
         oh54zaIKARYa4mx6jnWYRrjqoONAUbBtHkhCG28ZHddrheOVeOhANFy1E0MWjxDM/iPC
         eBTi/0xilwI2IwFpDd0vIw5uuzjYBIfMzCTTKdMio6fIZ3rTzKrRUTl7hWWSQqoZDqmY
         CZFA==
X-Forwarded-Encrypted: i=1; AJvYcCW1SdTJ5daGgpMOn/WmhxLpGs/+9dDUNdu380dqgAh3BMii/Xue1QLZ/THT4Mmr5xWFVUgg9SnYKfbfcaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzcrTVo6j/qtr1MWokUh7S9eCtvuKdMjeiCK55btkgA+lgfPX
	RS8nWrDvVjAlhVLuLCo8NdRTn9aKUWwSykzhOaDuKtoIdTDbuc4pDaurLsgLiQ==
X-Gm-Gg: ASbGncu09h2/fxp8pEdRtgdbBltbChSSgZRlSRXvf3DFtUu3EAv6EjX4cMFnEAbWIQ7
	ndL+JdGNJwGixHFvi7rG83ZHHmFhUfNkXYbDS0pO3s+EuMyhfMgc5MRJkBx879hK4ZqGTccGsws
	LGmUgI8pAPYpLeCRz/dj3yDXBfwezNPDmHor1rH0wRXHIqD4ot7OL7CuNY1vWi4FB2lwKnnRpU0
	jqfQ/MNPE1x3mTQUsLJCyFk1EgZIh1TzLKeR704CqDoJ5aXN+LHxo5hCrNnkLulsg+5Noe9xWNX
	J03Wh8ScpfR6yc7MM8P266XUlazw22fSRNMuguDdw0xV99jumALZtIpSUVrzYWKzj1R8e7VUv8k
	boTJP5H6gc2koth+waH0VzpomTxre7WulKZ1NbLzURj07tLXhOOPViebfDUWIOkHmIQ==
X-Google-Smtp-Source: AGHT+IFMpyi2+e4OHwtiricWrIVt0JBEYzdvNNclfSwQm0BtucmRnvCWV3F/sxNLkx/fCvtXvnqM5A==
X-Received: by 2002:a05:620a:2951:b0:7f0:21be:5fb4 with SMTP id af79cd13be357-7f021be64c3mr1018104085a.35.1756243456749;
        Tue, 26 Aug 2025 14:24:16 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebe6069a17sm758731685a.0.2025.08.26.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:24:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	j4g8y7@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 0/3] add COMPILE_TEST support
Date: Tue, 26 Aug 2025 14:24:10 -0700
Message-ID: <20250826212413.15065-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows the buildbots to test compilation. The driver has nothing
architecture specific.

v2: change to patch series and add extra patches

Rosen Penev (3):
  spi: rb4xx: depend on OF
  spi: rb4xx: add COMPILE_TEST support
  spi: rb4xx: use devm for clk_prepare_enable

 drivers/spi/Kconfig     |  3 ++-
 drivers/spi/spi-rb4xx.c | 36 ++++++++++++++++--------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

-- 
2.50.1


