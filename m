Return-Path: <linux-spi+bounces-5296-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC1A9ABEC2
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 08:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11455B23131
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666B145324;
	Wed, 23 Oct 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iGpQUzuf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37D147C9B;
	Wed, 23 Oct 2024 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665081; cv=none; b=LczFSz+m5YKnMfQwkYxoqXoVK8Ng9Z8ihKKEcWvH5J0RdaUsswY/VWuOAhVLVmAO6CY4vxlWn2v4So+Tvo5KbecFeAmeHq0d/gBsMxzcr40+8NlGXl/MSQ79hbDiko0w/pEReG5EQHb+K8KzuABC+UB8lCtJeKrvwaQOczhdt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665081; c=relaxed/simple;
	bh=ngQUyspk0u5tmnuw4tF5HJKltqCiL9AJbZfUWTdGVNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQ40471UqO23SaKBOUM0sRk29Jstb8BS1dwUpBxea15K2fBOFDX3KjZ3B+ovkCTHwa71vy5NJjL37sXGiVH2AMvZhwBXnHFpMaeJZHZXKe+kYKDJlXWp+tCbzaEs306aRAkJoynKVkh7ZGqVw+p1GfSPj8qdYjLCSqJY/yNqdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iGpQUzuf; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729665067;
	bh=ngQUyspk0u5tmnuw4tF5HJKltqCiL9AJbZfUWTdGVNU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iGpQUzufGKagQD2p8OJ9+o1rv05GO3s0irkkzl+B/jVQzK62CKg8qVz67X69ysnlY
	 guTCSgPYkdN689aKc9jSkAv2q1YkVkLU9aW1hyxIu8y95ubUmp7oLbbBrYPzSuQtxk
	 b6AP1aH471/Gf/Mf0lCx04AOx9Z8n7u1eTbhDMCE=
X-QQ-mid: bizesmtp85t1729665063t7rgkpzf
X-QQ-Originating-IP: /Pu5B/BFVMh1l61DmVeOAJ9BOb/PIqdl2onMEJbSJ3s=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Oct 2024 14:30:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5490330265754036757
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: patches@lists.linux.dev,
	nikita@trvn.ru,
	ink@jurassic.park.msu.ru,
	shc_work@mail.ru,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	fancer.lancer@gmail.com,
	linux-hwmon@vger.kernel.org,
	dmaengine@vger.kernel.org,
	xeb@mail.ru,
	netdev@vger.kernel.org,
	s.shtylyov@omp.ru,
	linux-ide@vger.kernel.org,
	serjk@netup.ru,
	aospan@netup.ru,
	linux-media@vger.kernel.org,
	ddrokosov@sberdevices.ru,
	linux-iio@vger.kernel.org,
	v.georgiev@metrotek.ru,
	linux-mips@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	dushistov@mail.ru,
	manivannan.sadhasivam@linaro.org,
	conor.dooley@microchip.com,
	linux-fpga@vger.kernel.org,
	tsbogend@alpha.franken.de,
	hoan@os.amperecomputing.com,
	geert@linux-m68k.org,
	wsa+renesas@sang-engineering.com
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various compliance requirements.
Date: Wed, 23 Oct 2024 14:30:58 +0800
Message-ID: <A74519B4332040FA+20241023063058.223139-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024101835-tiptop-blip-09ed@gregkh>
References: <2024101835-tiptop-blip-09ed@gregkh>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OHTF91J1Rz8hHcmuwSpKjbBoUoZhpUSlBvuksK5sCSl/z3VoTP0vAl4N
	1dHAHra4Np4fyto/bbVt43UDCsn7NLXDUNh5iYXeLoYQcbbFzWbVIpoYTE03C/1h8t/1u8L
	8ERmK8MW0sKaMNx53w/v1rLlOXn9oUWkJCjZuNsTG/xNBbyDiysuK5BuLHeqFWj+K7HrFqk
	ggbdJdw25YtQWLksEVyF606liPNxa6P1Lvmazhi6gX+6qgfLFgjgYffSrRUEfsMuAdcgWtK
	OxgOGAFs9tgh9n9ASJcpo0ENdeIcAe7eLJ5UJ7Bo3u4hZtufOciW93dwXJ/2niv15dipoem
	kRNVXXM8LExASYYw4xKGuoXH2S5UnciM8O0nenV/B/6hliIdy3uMoe7bGS1ajI5Lc0YFVaH
	A057WWcwbq9S4gQ46FsyYanFmUDBFlmR2VIM3Cq8N6KGcTlNGFGtsleWKwQgxDy7Jvc/xZV
	UW91jouYjEWZSoa9z7XtEb+cNy4Q7mhzLngPNCDK9gfCwtXcZFI/2KdtZ7mQVX2OqHl8BqZ
	3bMrZxbNUCMtOK0JLpZuU9v2Sj9bh9B0ifVCcgE37rBzLtb3VKq7RlkEj5ek75uAxuBj/7V
	tAG90ubNemZBRBBQAH7UwP4QOR3C1W1NqFBkln6nIVsnjmBpcld+FvWzx/IHJ4SNnl+sVVN
	Rac1Dtq15CvUBsfah11nxPqvr76OLEkglxzL8RVMpQgfETr4JA52AIcMaIBvsqMhElYJTlG
	wc2keO+nPHrdGopZDfryVS1Es03SH5LDbn6w00/SVe2gp0wM1Grq30QPlNCps1KMCyjnFJG
	fEYEVc7N8nwue960aKpP4EeJe8xaKiYSIBKrCd8l5gLtgt5XIo10LO+33un1X65I+v5BOJv
	37AGKl6wBtX9r6/Xj2DGSbDPIsWGy6kUlmNXgwvg0q4ZSTrZqkZlBHqoGC5HcthTHqMZV/1
	bfu/PJjY6SmjHvQvBdngCuM7+
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Although this commit has been merged, it's still important to know the specific reason (or even an example) that triggered this change for everyone here, right?

And those maintainers who have been removed should be notified.

It should be CC'd everyone who might need to be aware of this change, including the removed maintainers, other maintainers on the subsystem, and the subsystem's mailing list.

To ensure transparency.

