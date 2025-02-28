Return-Path: <linux-spi+bounces-6974-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73103A498A1
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2025 12:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D803BB4FA
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2025 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D97225F781;
	Fri, 28 Feb 2025 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coldcon.co.za header.i=@coldcon.co.za header.b="Zlg5zVHX"
X-Original-To: linux-spi@vger.kernel.org
Received: from outgoing1.jnb.host-h.net (outgoing1.jnb.host-h.net [129.232.250.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADC23E32A
	for <linux-spi@vger.kernel.org>; Fri, 28 Feb 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.232.250.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743894; cv=none; b=Vt7wnmq3UKtKZ6appn6+bWHcxDyna+5fMnSWC//0P8kTFVNnlnaibo4Uhc56htDULsusxbqKJzDm51vgFngG9kTDwAcNL8bexysBncMU3Vdc281d7JlfMjxyeGYTWtZ6hK1OvVOk34z3zmjdTQJZxYKLVBY9+phbWCHIP3O7uFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743894; c=relaxed/simple;
	bh=LnJAb5OtSiiPPpVmdSEicOxdfy335XXtHun9Lv2d8Bw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iFAlU9lpKxDsyAi9jRyESlawtcDazZL6JJzsRQqUr0MRs8Ff09BSQUGzOpt3qE7oq15nJiFY5epoJCixtNoGwSK9HdrxX3IOl52IMdPEH5HZ0Fkslija3B/UK8cIqQqxZZxC+FWHI8WdHjeBs5lrwPo1dpsoLZ9he0XHxYtMAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coldcon.co.za; spf=fail smtp.mailfrom=coldcon.co.za; dkim=pass (2048-bit key) header.d=coldcon.co.za header.i=@coldcon.co.za header.b=Zlg5zVHX; arc=none smtp.client-ip=129.232.250.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coldcon.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=coldcon.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=coldcon.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=t+qwmUT3iOAm1DfPM+nbVN5TXLHXkSwi3Xte37fm8Y0=; b=Zl
	g5zVHXC0ic9lNsVizlVTaP7nauG87cqctZHGtgrEx0hsHEAbRoNINk2/ER+eE46oUmlFrrNjOqZUu
	vgpjd4JEgeuZPPXeZhLPTKB1mG4viGuyf6CN7bCzbfxZCmJCvzFYjZaQtpRShaHIE2Y6+G3eIeeI1
	vLR+lC69CkcBKBFtDLi7o5cu4I6NrOkKL2Q02wuRmpDgWUiW2RdUrlfr7YvFumsbrQY2pYBVgQ2I6
	LtwTntSZoF13pg/iYLLJaD4w8wROQXdXMx6UjLVHUbAHXfLzmhLmXWG2TztTPegjJUFPFbUSqupeX
	/Cgyzg7M8sS5aAk302EbyelBsUeVyZEg==;
Received: from dedi166.jnb2.host-h.net ([41.203.16.166])
	by antispam2-jnb1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <avaril@coldcon.co.za>)
	id 1tnz0L-00422w-LR
	for linux-spi@vger.kernel.org; Fri, 28 Feb 2025 13:58:10 +0200
Received: from [104.192.5.240] (helo=coldcon.co.za)
	by dedi166.jnb2.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <avaril@coldcon.co.za>)
	id 1tnz0K-00000006Dsm-2QgM
	for linux-spi@vger.kernel.org;
	Fri, 28 Feb 2025 13:58:09 +0200
Reply-To: funding@investorstrustco.net
From: Iyke Nikolas <avaril@coldcon.co.za>
To: linux-spi@vger.kernel.org
Subject: Re: The Business Loan/financing.
Date: 28 Feb 2025 11:58:07 +0000
Message-ID: <20250228112431.68B0F40CF56D2668@coldcon.co.za>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: avaril@coldcon.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: coldcon.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@coldcon.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.88)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+CzanhUpQxxY0jGcn2Rs0cPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5z7QsSqJg/tY26zecnzp7YKU2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8sq3xHGjwY23W/fr1qIdwR0ceb4o0/MLsfRXq2B6Bj1eqIhJNeUYrwmMRp0o
 fTv2z6OWrRCR/TGJ+LxBEbBCS4VQbvH/y4TBKwDHfQa0wCenXC+SjAMhlxVTUP8RXDYi0U1JpmI0
 71bWBu5BNTe7wFyCRVEbXfJnI+gG5QvGXTtovK7VZqJmzCeHtqZ+QtMgTB0iLwRMaKsK8lAeAhb+
 aZDwTMQ3Kg3hL2oXz5A5E5R/dS4GkJ5hfB+qWugfDEytZYoACfRtBjLzEjgIZNLWhI/Mb7SOSczA
 6/BlLHspgKwfxkpFBMGtk0DHIsZm7eDIdidx3dBtceKX2dWiEm+7oHm9xBEeGmns8QeFADnQDTrf
 rq/iPB9nbD8ib8/LRKDL9uX6nH0SFAAL0wIn8kjcTporPPrEMEUywY28JQK/4tt3rRkgoL0bckEu
 e7jwJnlVscnY5Qx4fJOk03R5fJtf/Dv/9m9+uP0zyEETyQahh1k9u6fK30DS261NPJJTtvuBG/wS
 fPVkeRJRF5+7mPhPAjSIa1y0Nm02ZI+0HyPfbVEuRae1snr4e+V5iJLuGQh14kIlS9YoHFltGqun
 dRd2vfQDxRcLZivEDcmpAbM9ZRc0AilfB1kGL3fSE2MONRlXMKtuCu4G2nFtWAVIvsCOu5FM/fu3
 x7erbsjFB4F58vtkzTwlrzSXg1zOM5BMYR+ArXzMM41wUaeD7iI07wk7IBC1aeNzMeYMM/qc9He6
 zd8kb2nrAUZxhra3hcJgPbkQnKk3ClTXlSfQV8rvfnHgqk4U1Gt/9ppEoh7u4mXKDwivYDdQSwbI
 5IDQMARnZ2/ixmby7m9xwLahPGY0/PEbdICFRgFnzGg9rgSSO4p0kGP/3qk3UfKQ9OIEeAN+Uhcn
 OZzPia/e3RTzWtZ565WlxfE2
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net

Hello,

Do you require capital financing or low interest loans to advance=20
your business projects or growth strategy? We can provide with=20
the needed investments for your business. 

Get back to me if interested?

Best regards,


Iyke Nikolas
Managing Partner
Investors Trust

