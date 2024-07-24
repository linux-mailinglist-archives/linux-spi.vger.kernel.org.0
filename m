Return-Path: <linux-spi+bounces-3945-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFFC93ADE5
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BB81F214E6
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483DC131BDF;
	Wed, 24 Jul 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Zxs88aWs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E11AD23;
	Wed, 24 Jul 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809403; cv=none; b=hWUuPbB/206UvTGG4rxZqvvfX9YLhh7+YTyZLZKLnDoQaTegMngH7TxV4HkXM71sSA0ceqlZ/Rf2T8tDSJ1EkoeumKebg5Dl0OI2U9iLF8r2eQxTh9gLJ3SFsv7MGNJ9jvDGrEYWNYW/SqkthEjIp8ztbSNQKRdhxMi29xhHdbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809403; c=relaxed/simple;
	bh=s6AH41qmCRagNHJVLWAEWXkuwGW3PBip+cWwm6AKaLs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DlO0GKaS6B7l4HDBWVEVKPQqof273qQEv2cYI5cZX6OF1qBaZiamg9Oyu8pd1A9sTNp6wNP0Tv/XDAc+nQWLidMO3xz80kSrYeS/xmuOUrD0KFOZm+zUZkGer9aVDW23MyQD3349k6f3vewF419JpeK+wB9Eb723TzfNkgIGGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Zxs88aWs; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721809369; x=1722414169; i=markus.elfring@web.de;
	bh=AUfhg0RIs62oOdn6dwn9X3BXKwMPFuwRHSPTvaF4wUk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zxs88aWsKKvdQQvzZsAmPyvKmfIqcyxTlvZ+1NfS3/j5dUXTzmrNr26VHLwCjdQT
	 H/VHvfMeKjgwNyE45Vn+lung44K8pxm3EiCmxah4ITZEMzn4s/NzkA7wpghFAeuPA
	 HboA7CUt87YgT2xQEc6achd8HI1JZ1zMCnfm9tFAlx3f4MTq5o4bGaPLp5EVz+/mg
	 6A/JgkrLW5QucLOEOITZSwsqQvCSYsfzduETDm94IK2Mwq+ilkS039/XUaD82EoIo
	 E4CmrdJkGrgUF73WnG1pbtVOQX1mdw7Yxv+tyuUseXtoq+O96ZyxqflM6un2AhYx2
	 iuvtH5K2cNmaqLRy5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGWe-1sOFoZ0H7i-00CEVw; Wed, 24
 Jul 2024 10:22:49 +0200
Message-ID: <22b7c0fe-df71-48a0-bb80-1ec5c52bce2c@web.de>
Date: Wed, 24 Jul 2024 10:22:47 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mark Brown <broonie@kernel.org>, make24@iscas.ac.cn,
 linux-spi@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Stefan Roese <sr@denx.de>
References: <6234dbfd-c153-4f67-a828-342919d41de6@sirena.org.uk>
Subject: Re: [PATCH v2] spi: ppc4xx: handle irq_of_parse_and_map() errors
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6234dbfd-c153-4f67-a828-342919d41de6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LlgikOoZ13trhpbe44hcZcpKHM9A9Dwwrop3zA8ZIw6hiivVBCY
 er+w0ufgryZLK9vHpIpxn3Ke/IuLm0dl1K79KAcX6dzJMTc3JY5CAnFigVBKmImeHbDJAWe
 5EHBsCcq2AXHiCThuloZcvcsAs8ipBDes8/0yusDQEqQojoPFCkDg2cC8LMUReVXtqpJ3r1
 Z1zq7eX72Eido0W/avfcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w57jh+J3j94=;BwBb5AHKwBMVOEuXKM99xo5Gk9a
 vYVDUZ9FIlyNMuqF2vghLRqu3mnE+t9eCQji6bm+cMCyc+BaJckmbNSiTovBc0at0ZG6iH7wf
 P3xPdmK/+mjfxQjwx3Pj8tnlRz/kZW6DAxixPHRNiMidREbzbb7Q6yxyoF48SsqEkOOjSLhGS
 9ktId+hoVIDDl2psbL6Jen5ORQWVaZtM85sHKmnOqL9MmuBgWfCkAxHlS6G1XjlopxTLbDRpc
 yz3r8OFjcwpV3bK+3pxjowhHgJZ9XPo9Jiw3qedErIChuMkGyqMqGHydMfB/1q1ADeziGxxV7
 jyB4XSt4MBIN7wlUIoXUuwCzIkd0ZeBOT/IGBIcbbcitCgFMTVEJR8oSRxIiqhIx7FRaL9jfu
 uRZf6+eldNrWm0XH2ZMp2+OGzn3ElAb1taAsLL0LeWFLSfqqo1DhT3qnx/8XuKNnOQ/UklcKG
 SADcHudD2QYeLGGF2hjQCVJ5cOIVoEbLBAWXiuGVUa2Tnkr7AGP66Q127krv5+D6AJto6p9WR
 T2irs0CElLRzKE62Wu8eXq9t/ksmLPnXcMkDqKXozf3MxyyYiKvqBfvL4cEKxmRHiWDsrvZZA
 KmWuClPm3xnYr3cB4hve4AczDRPTWgjZrHNkWRtfCy7t/Xqoi5p7YijXoAq5SlSLmz6SruTRM
 Xyv4U4Y0GgbJoZ+SJztqlR4simaPMcnyguVtpJPvrK7xGHiHJkPiTd1gey34LtHXV3Xb6nqbc
 cfQvV28x4n5SnzKBJwbdnqNXNm38jI0EnYAq9Amiqkc+W5v0f9XsJA9qbwcTTicOQ7VH1UDvR
 rXJGCIr7M6P8LBGhBMdqNcKw==

> > Zero and negative number is not a valid IRQ for in-kernel code and the
> > irq_of_parse_and_map() function returns zero on error.  So this check =
for
> > valid IRQs should only accept values > 0.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 44dab88e7cc9 ("spi: add spi_ppc4xx driver")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > ---
> > Changes in v2:
> > - added Cc stable line;
> > - added Fixes line.
>
> The Cc stable seems clearly disproportionate here.

I wonder a bit about such a feedback (according to a commit from 2009-09-2=
3).

Greg Kroah-Hartman configured a patch email bot in other ways.

Another example:
Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in ucsi_display=
port_vdm()
https://lore.kernel.org/linux-usb/2024072333-popcorn-detached-f399@gregkh/

Regards,
Markus

