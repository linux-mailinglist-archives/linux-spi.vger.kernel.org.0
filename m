Return-Path: <linux-spi+bounces-11063-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D56C3730C
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 18:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E9274EA38F
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A631D6188;
	Wed,  5 Nov 2025 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Od4OuV5D"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3A1C862E;
	Wed,  5 Nov 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364728; cv=none; b=Dc5GRrJ8KlSjfxiF6oI3ySayPETzu7SaIfD0a3paFchDwvJy34tWeiXuxDGw/RV7uNyrmnip4L+A9ymyuAN3K7yl+V6pMr1ozkBIgOt7cCs/jJ+HsF4LLN4s4044tTIGX3m62SxihiSrVjk6s/S4nGBL37A2c1CyG0tVCtNBMBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364728; c=relaxed/simple;
	bh=CC3C9I31YqRWIP80GNiLECrPj03uKWy3j05f2AXH34I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Jf9mbizM13sE5/c6sfIyBd75HlAg2B4NFw32qTJx9WEN2Paf3TMYOniriioMvplH6C4ybtfd0hoCTbady+DF3eKSlMiSPw7Mdt06DRClqf8ESJrHtx0gUTcfadKNPRCif6i0xP8kItquXU5lDqx0zHpcskZz+2VsvH/NpTriGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Od4OuV5D; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762364672; x=1762969472; i=markus.elfring@web.de;
	bh=062oThQfCiAu6RO0RcHJ7UUZxncftkZICnZEVJAs4lo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Od4OuV5DbXNYRcsHDU5X9ll7ryJSe0auYV2mmGCpeuPnuP/cxxKmB0N2khyPOsgN
	 y5FbWA37hFsFIDPEAHAovhEV/yhZEbao12yLt80RvMVFzX4V7HaV08UXOiCK2/wms
	 hzNHstO7e5bWTRwYueDS+HJp22p2HrIfsBtqRr6QJnVs0kdyuk91FODLrfIXHT8jv
	 Y9iQtQGB5soFgT7wsrm7IolvSMVNRr2+FcVmglTWaTwMqQwl3rJkbiXrPCitIoMIZ
	 9TetPnCLi6w56ax44sc+AKIjm3FEQOlHCjY048ajMHRQY58CpqQGZNsRvofH1gf8s
	 nXvCWZu5VjXApllk8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGuC-1vYuvu05by-00Hw0X; Wed, 05
 Nov 2025 18:44:32 +0100
Message-ID: <1a234e96-b41e-4f6c-b23c-e57426ff6aa1@web.de>
Date: Wed, 5 Nov 2025 18:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, linux-spi@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>
References: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap()
 memory
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jot5tDQJo1L36cL8JOgENIFyiccB0wx8wvoPXnsvMFO7Sx3sCtA
 qDsGMlMmcQ2G1W/kFisssqz4WcxD4S2GeztozjrMc1rGpu7fh2OWU3/BgAAJUJXdzmCVbdC
 pVeLpxkUuTNVafWFIW+Axl3Qcxz9aLGDtldOUyCrvVFAi/vxOOA9Q47kD1xIZECAE0gl0JU
 Exv31t3Z6fWyvu8AgoBDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y3tOmy+s550=;Vq3Xa/8PM7c7WYUJcqufPVueOLZ
 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
 Eng6ujTNmnh2u/Qy9gP5waVNp/uOM6gefvg=

> The AHB IO memory for each chip select is mapped using
> devm_ioremap(), so it should be unmapped using devm_iounmap()
> to ensure proper device-managed resource cleanup.
=E2=80=A6

* You may occasionally put more than 61 characters into text lines
  of such a change description.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n658

* Would another imperative wording become helpful for an improved change d=
escription?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n94


Regards,
Markus

