Return-Path: <linux-spi+bounces-7051-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185ACA54566
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 09:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6C97A6EAB
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6175207DEE;
	Thu,  6 Mar 2025 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gYr2CL/Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E801A725A;
	Thu,  6 Mar 2025 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251078; cv=none; b=DBmQFcYKsC4Lm6td726zooWTfjSMCOACG71tYjd+jq4NmCRbg+19/ByIk6U9+d//cPWbR4rTw2ErGKtS1nHqv2Rndp2ju7H1ixUbKQTsvCHX6aUEjhzQC6chN8mZcFo9V6e7b3p2Fh4lwsfz9JXl3bnvfXlXv/pW101l68LGukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251078; c=relaxed/simple;
	bh=h/lUaBxGj6baOEw90+IoY5se4q/jvtZ+Z8jE+u1v78g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFglnxFHAf+D5phhUKkcX4yoarZH6Ybaj4uzl3OEC/86rlfUab+S5tGXQWIN8t7KJBD03oJYS+zvjBb06ga9Tpc3DdxHgxEzQrm6p8G8m8D0U2l5pfq1+DEhur6HliiF+cmKDCN/a781FDlRuX5uY7IOTKlUX9nPoMRXtuzr4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gYr2CL/Z; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4DDF20454;
	Thu,  6 Mar 2025 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741251074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rybuAcSziaYDDoBLq8b00R+CeJTuyyIVxujpakqDcq8=;
	b=gYr2CL/ZOqPXOwGFa5YzShb1yKLAKHTOwyXrOFbMDNjmkBHeHR7KOLhbtjyunL7BWul8ZB
	BMUsCN4gz4qPWf/VCaH6LAwdFUQFTg4JBKrG258UPll/jOayfZuQcU1oMqzNU5V4894Ux+
	WprES7m4n5KEgVmCgJTe0GbZKjtHLpbP56pJntUj3LwdCz75/AYhZcKmvaBuykDB3S14O+
	zypgTxDBPh3F0FFzMRXzKCbJ8Sv/ySp1mxYlTL+HLGzkXdEzoo14Yt4Z6zFsPU5FedLGZa
	9soTvn+5PtnHmq0//naQmPXlD/chZnJbbCCjg6JGr69yAzpsAVU1e0fl3B/nPw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,  linux-spi@vger.kernel.org,  Rob
 Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  devicetree@vger.kernel.org,
  Vaishnav Achath <vaishnav.a@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/3] spi: dt-bindings: cdns,qspi-nor: Deprecate the
 Cadence compatible alone
In-Reply-To: <20250306-glossy-quaint-crow-dafbe0@krzk-bin> (Krzysztof
	Kozlowski's message of "Thu, 6 Mar 2025 09:43:03 +0100")
References: <20250305200133.2511308-1-miquel.raynal@bootlin.com>
	<20250305200133.2511308-3-miquel.raynal@bootlin.com>
	<20250306-glossy-quaint-crow-dafbe0@krzk-bin>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Mar 2025 09:51:13 +0100
Message-ID: <875xkmwni6.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgut
 heskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhgrihhshhhnrghvrdgrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

>> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> @@ -81,6 +81,7 @@ properties:
>>            # ie. also NAND flashes, not only NOR flashes.
>>            - const: cdns,qspi-nor
>>        - const: cdns,qspi-nor
>> +        deprecated: true
>>=20=20
>
> Please update the example, so non-deprecated device will be
> documented.

Good point.

Thanks,
Miqu=C3=A8l

