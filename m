Return-Path: <linux-spi+bounces-5599-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE09B9DEE
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 09:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383541C20E5D
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55385158535;
	Sat,  2 Nov 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="DCiN/7lk"
X-Original-To: linux-spi@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0BD433B9
	for <linux-spi@vger.kernel.org>; Sat,  2 Nov 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730536845; cv=none; b=phFOLroY+OZIIKwWLcz4IR/kXbyoy4NyYk1Ow3y3BGz38CJAmkrwInyA/0mJT75AL+qyg0gkUD12Z0BAa5Wr+XlpzU7Sl5fHarR0jawcT74d6KCWTs+c7J2ViHbuveTKkz1qV0wsGIr9s0fWtgIfXPPx7XwoNBzBgUl9T8yj/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730536845; c=relaxed/simple;
	bh=m1lACV1FyspB0fk4RuDq9MTLVdmNSTyuRGA+rMaKps4=;
	h=Date:Message-Id:From:To:Cc:In-Reply-To:Subject:References; b=SFjHT1tU72mIDbmMcyw9sZw2anrwIlh5yp4s99DsFbvN7Z9NblQ/mf1ttzqJ0t+RazDGuXiMjdsPQRGcJVmzC0UKdzma0wSWk584TuBEmnkH4p8HV3WqcrHih5nWhuL9F2bbkhORe5ke+oVtRFVhiJDguDFF8hYsl0txjwpfRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=DCiN/7lk; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: fb73fc64-98f5-11ef-8d51-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fb73fc64-98f5-11ef-8d51-005056999439;
	Sat, 02 Nov 2024 09:39:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=subject:to:from:message-id:date;
	bh=SOESJwGk/m0BH7DybjWTyh29n0WPp4jHNYg51LnvExA=;
	b=DCiN/7lkFwO7MpBe3tmDSRHPmaemcDLP0hYYF+3E4NLEKN03H4mHJXcJZNNAAQlKxBB8UdvZAG5Jh
	 J9b1D7HY8/MXxQ3mnDq3KPRYsLpswke8pXjjQBYptWt7T+5DeHyNFbWnbxgHZ6uwLDIP3l9N13rgEy
	 r7LxcuhaiwExkywlMDZef8K5EX+wo2iDlQCpN8grSVSppyPStgzGcX6//DIFp1ZqyzmhdSX/N+g7jh
	 K/CsR3ka5AuXmDwIBqP/awaYO/jMoVlZuiUz+2b+1ynKZopZhcYy0r/c83DFbVdGd72ynJtr4cwhsG
	 +mkoVNjpDzs63hctmVGQ5H1LUBJmdAA==
X-KPN-MID: 33|CNLLXHK/GrZqDr5w1I7erOjxXIjBx9wdE9L1Mf0wjG4F9Zpd3D6Gd9zERmwBM7Q
 mPAkEG/BAmO2jCnY0x6OdybuAiCXqrxgsYgj7/db/epk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|B9RhJaWMW/sEKQDBuQQ0hglTReDydKiDe86GzGIp1EwQCBNJ8VbXfe9UflrnJU6
 XTpk5Yf0qfQGb+IcfLRUk5w==
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id fb974d63-98f5-11ef-9749-005056998788;
	Sat, 02 Nov 2024 09:39:33 +0100 (CET)
Date: Sat, 02 Nov 2024 09:39:32 +0100
Message-Id: <87wmhm3u7v.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Nick Chan <towinchenmi@gmail.com>
Cc: j@jannau.net, marcan@marcan.st, sven@svenpeter.dev,
	alyssa@rosenzweig.io, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <46b31874-9fe2-4534-9777-816765a265b1@gmail.com> (message from
	Nick Chan on Sat, 2 Nov 2024 10:36:56 +0800)
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: apple,spi: Add binding for Apple
 SPI controllers
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
 <20241101-asahi-spi-v3-1-3b411c5fb8e5@jannau.net> <46b31874-9fe2-4534-9777-816765a265b1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

> Date: Sat, 2 Nov 2024 10:36:56 +0800
> Content-Language: en-MW
> 
> On 2/11/2024 03:26, Janne Grunau via B4 Relay wrote:
> 
> [...]
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - apple,t8103-spi
> > +          - apple,t8112-spi
> > +          - apple,t6000-spi
> > +      - const: apple,spi
> Apple A7-A11 SoCs seems to use a Samsung SPI block, so apple,spi is too
> generic. Fallback to something like apple,t8103-spi instead.

Well, if that is a Samsung SPI block it probably should have a
"generic" compatible that starts with "samsung,".  The M1/M2
controllers have a different SPI block (presumably) designed by Apple
themselves.  So I think it is (still) appropriate that that one is
"apple,spi".

Also, (upstream) U-Boot already uses the "apple,spi" compatible.  So
changing it for purity sake just causes pain.


