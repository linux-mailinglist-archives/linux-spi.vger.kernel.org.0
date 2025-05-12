Return-Path: <linux-spi+bounces-8072-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58CAB30EA
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 09:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4C73ACC60
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8F255F48;
	Mon, 12 May 2025 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cXBu04rn"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7023A9;
	Mon, 12 May 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036660; cv=none; b=sRtoIf72uKUMizi9H1XOtqPB3uBpV21R8aJIY0SZd0ZLnW/hZrQz6n9Ub6npt+lHYcbKQYQ0P5jEcOAqehHc4NqyvuYXrEZPCWV4asOZ72vyNp7hGQx/D3+m1FgsyxA5a7ksNY3QhQ6wtSH5an13N6HHAmiOVuvHJYViSJr5HXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036660; c=relaxed/simple;
	bh=0UXmvT4l/lV+IOemda0bORxvLERjQAhLzRUt2IKiC9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rb4juYobrEcdATewEpWf9lLkNpK8Y5geOL/Ld5Apj8fJPYNXgvdP/fims9SMWD3X60mX/J7nlMocixJl4w27mIUJLxwrktDsCtkQvlo7CjXDIDdOJqKzynIz53IoRSHcSmCBZr7mAxwFFOm1D1pvsMKmVUrw8Nns+AgsT5wAtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cXBu04rn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4263C443B0;
	Mon, 12 May 2025 07:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747036649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UXmvT4l/lV+IOemda0bORxvLERjQAhLzRUt2IKiC9A=;
	b=cXBu04rnMwdt723IhMe6evlmHTiMH6v6VHqlcJfe8ePya2grX9TZw9ykAIElFNUeyZkPmk
	bAq7cjWpS1oEF0Bvwny7r1eKLNMAldacyovQ2FJ4IcFWlzsDBqfhUdh76Q8XXl14ldpCHB
	EBrPBuiX0gu9E5D5GY4Tu1Za0gh22dsg1TuGMlaore+S1z/xPWlIzZrT3/KPth+sk14Nnr
	WR3d3fDJTlJ9+NvrGOr7Ya+eAqgrY+HzQ9aayE4Nk+NM61CLXLt679mTdNwOLttBKbm8EP
	GboUsV5ccTuBxGV7VveZGaz6bW0L556OopZYkdrf+AlkaR+fiBM/oNE90Mq9vA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Luke Wang
 <ziniu.wang_1@nxp.com>,  "broonie@kernel.org" <broonie@kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
  "michael@walle.cc" <michael@walle.cc>,  "p.yadav@ti.com"
 <p.yadav@ti.com>,  "richard@nod.at" <richard@nod.at>,  "vigneshr@ti.com"
 <vigneshr@ti.com>,  Bough Chen <haibo.chen@nxp.com>,  Han Xu
 <han.xu@nxp.com>
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
In-Reply-To: <mafs0zffo3gea.fsf@kernel.org> (Pratyush Yadav's message of "Wed,
	07 May 2025 09:43:25 +0000")
References: <DU2PR04MB85678048FE8B475B1E323E0AED802@DU2PR04MB8567.eurprd04.prod.outlook.com>
	<10b40148-b949-442d-9d43-0db09517269a@linaro.org>
	<mafs0zffo3gea.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 12 May 2025 09:57:27 +0200
Message-ID: <87cycep8go.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepiihinhhiuhdrfigrnhhgpgdusehngihprdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgp
 dhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggt
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 07/05/2025 at 09:43:25 GMT, Pratyush Yadav <pratyush@kernel.org> wrote:

> Hi Luke,
>
> On Tue, Apr 29 2025, Tudor Ambarus wrote:
>
>> On 4/29/25 10:03 AM, Luke Wang wrote:
>>> Hi Pratyush,
>>>=20
>>> I'm following up on this patch series [1] Avoid odd length/address read/
>>> writes in 8D-8D-8D mode. While some of the series has been merged, the
>>> patch 4-6 remains unmerged.
>>>=20
>>> In fact, we also encountered similar read/write issue of odd address/
>>> length with NXP FSPI controller (spi-nxp-fspi.c). Currently, we handled
>>> the odd address/length in the controller driver, but I think this should
>>> be a common issue in the octal dtr mode. Was there a technical reason
>>> for not merging the core layer solution?
>>
>> I guess I stumbled on those small comments and did not consider the
>> greater benefit of taking the patches. No one cared and we forgot about
>> it. Please address the comments and resubmit.
>
> Yes, it should have been a simple next revision from me but apparently
> it fell through the cracks. I do strongly agree that this should be done
> in SPI NOR, and not in controller drivers. So it would be great if you
> can respin the remaining patches of the series.

The fact is that we will have octal DTR support in SPI NAND as well at some
point, hence a common solution would be welcome as we will likely face
similar problems when performing these unaligned accesses. I don't know
how feasible it is yet, but if we have a fix for SPI NOR, we will need
something similar for SPI NAND.

Thanks,
Miqu=C3=A8l

