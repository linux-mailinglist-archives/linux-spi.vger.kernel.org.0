Return-Path: <linux-spi+bounces-11065-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4822DC39522
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 08:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 850BC4FAC0C
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 07:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802126E143;
	Thu,  6 Nov 2025 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HJTTxuzf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201A2BCF4C;
	Thu,  6 Nov 2025 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412547; cv=none; b=lBzgz3wzj2ZgFSILO1aK60ZjlypdYOx4uS5ewYRQ6aYqtqiPhFgSigasO6esqqDOyIunBMA5zpuThYQhH6uCF/mxRwlqasWy4nCrrUGYBjlKwmfZGfEedSmQ72rsEltB6MM7PrQ0sU84cuv6VQDaOS/dqiRWCYJCtl8dwKowaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412547; c=relaxed/simple;
	bh=fGPLWiFY4pa2oYzVEMbw1jOnu07BWKkpz/Gs+arx8zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWp1thnxoPWncfr7BfswPg/a0Ploqa5kvC1vFI8xDnHhEooF+o7/FxVusbFOC4d5LZjSsbH9du3Zmn6CwcXL05brcOrtaMXXm9CgqJBP8Asjb65ZT+RWP4ZZwf9w1xQCgNZu7Hepogk/BhNIul5+u5viKhdzaNjIeDHFb/lOT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HJTTxuzf; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762412542; x=1763017342; i=markus.elfring@web.de;
	bh=wJRRyH1biVoQpuVUMOuahV2xY2HkN9uZ9WuOiYC82es=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HJTTxuzfxLdgb8c6b1Myhjh8Tr3DTCONApo5RD7nmPuleAzbNd6t3nrEhZ21VKYO
	 UK9LpFhk6nPd0O3WedENt+Jso1PqnUxM7UCf8fwIwIhyvd9k8G29bYvTOaEOZOWwZ
	 DjcegI09Qw7mBHEz7+6HpQT1D7qd2rf5W91oyEUlplm19unMcyoePfsaoqODXyRJB
	 nV2jFdreoRbF4SVvlKDyEvfnMvYpH1uPb25VO+9OKiOYcT9emOV/+gex6uq7oAj3l
	 pyj3E6cPY0y0vqmp8vesVN8u1MnNnd4KmaYd3l/CzD97WpN+UFTh9oz0/8D6xqrKk
	 hM8IL5GWO5SdZBliaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.214]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMzM-1vPBCS2fZO-00Ccl8; Thu, 06
 Nov 2025 08:02:22 +0100
Message-ID: <f8edb81d-f38a-4756-ab58-6bffd9ac501e@web.de>
Date: Thu, 6 Nov 2025 08:02:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap()
 memory
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, linux-spi@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, BMC-SW@aspeedtech.com
References: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
 <1a234e96-b41e-4f6c-b23c-e57426ff6aa1@web.de>
 <TYZPR06MB5203380D58961A36922E0436B2C2A@TYZPR06MB5203.apcprd06.prod.outlook.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <TYZPR06MB5203380D58961A36922E0436B2C2A@TYZPR06MB5203.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wPBf2YQTiaXxrbnaV2IYm9gh7k0gc/6cfk/pxby3/CaDEx+9fkv
 yEuq4IajSOXl9D9jXeJueK75jbZTAofY5DH/UBnvtprpln6OhDTnK00VdXGPtpfFG8lJj2w
 NZ3qIymA+C6O+ZkKj5EErsHPzTMD8dfHU1c5hBdhN6V6OTX4wvRwVVZqdhSYkTOHAmCA/kc
 zfHnuqtjsTQRnhKLE3Y8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DucKiG8aLfs=;U+2xBOGRHUc0OQqeiQil5V0Cgpi
 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
 +PHuos7ffGlrxw==

> How about change the description to the below one?
>=20
> Use devm_iounmap() to unmap memory mapped with devm_ioremap().
> This ensures proper cleanup of device-managed resources.

  Thus ensure?

Regards,
Markus

