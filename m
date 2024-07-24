Return-Path: <linux-spi+bounces-3959-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693E93B0BE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 13:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B645B21B43
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D6E156C5E;
	Wed, 24 Jul 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="od17ZgB/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428815698D;
	Wed, 24 Jul 2024 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721822139; cv=none; b=l3WQG2oq2+HxoZQPHIaZgkSBhaMSPf7VMWIt6ec7E6K8leiIBdprhbtlUSgtpwKGrb+f6gX7MqStd/FcvoN11STFqZUQRM4nC3rClc9sVEQLcI4dXDnOcTY+utt6D+YleCagxWZI3UerF4BoII9zPa9uAJVfElnTZt2HokvSdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721822139; c=relaxed/simple;
	bh=3KzmTP07azLvBhVt5oUz8fKHTgKhISq1ItXh7wXN3QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SG74WJ1vPnxxgXgadoYmDOCXG2SaIi7mzdbXWA3Qu79QlpNytSC1quO+zIKQeMz9qP0jTkGRbHIyoX+l2vfzefP1ax6fV2lYgmZD8pWrPtn+XI6AddXKSHBZuYeI1VfAtFr7VBY7+8VLNeuh++nFr6LvOhHR3JVMewRyOwAQ/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=od17ZgB/; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721822123; x=1722426923; i=markus.elfring@web.de;
	bh=3KzmTP07azLvBhVt5oUz8fKHTgKhISq1ItXh7wXN3QM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=od17ZgB/dlZhhtknmee/O7oR5M5b4dfA4w5jLBFzM96S/8FFVxFhx8Iqq1XOsbUf
	 0qvP5bmiw8o/jW3lNaaQWIEH+ttS+0iy+l2gFxUgMSDc6ySeyS2VmaNLrJCx17tmH
	 G40YlXNyBDpBtlWas4lSCOwAGvXyWCpwjLkzYJ7Wohy5wJUYMH5LwBD0fXJBMXxYY
	 26CmVR6jOF7QhohKHDVcSWeVvahNzxPIChba6c1PxD03tS2TPok+blqFBvXBePrbD
	 BUjB7Jr1L3MOxqbqvPopsJWM3WGPQqfV5onRxQMwMiU+ItA1g/reiZo8eeGyZzKrk
	 OOKSjGvVlQfTFlmSow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UgI-1sD6cj2ate-00v0yR; Wed, 24
 Jul 2024 13:55:23 +0200
Message-ID: <37c5b0a5-7c57-45aa-8155-7aaba6579a48@web.de>
Date: Wed, 24 Jul 2024 13:55:22 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] spi: ppc4xx: handle irq_of_parse_and_map() errors
To: Mark Brown <broonie@kernel.org>, make24@iscas.ac.cn,
 linux-spi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Stefan Roese <sr@denx.de>,
 Wolfgang Ocker <weo@reccoware.de>
References: <20240724084047.1506084-1-make24@iscas.ac.cn>
 <d8d29c4c-4c66-42ac-9e2d-821502b5f55b@web.de>
 <514a8b85-e4f0-4b63-911b-69ab962ee591@sirena.org.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <514a8b85-e4f0-4b63-911b-69ab962ee591@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y6l2TV99C1YspStoh1Pe0JSrejytHSo+ycCW0iI5swbxM3hyDnL
 D6TSjylPihQ/Vw0F3haEHnFCA8lRF24k811zo9fZDW1wgTTv0fnbgHoh+YyOl6xS4Loytzy
 64IxGmYiGAvLhKgkIYIlYIUYhqof0P7yrT3SCbkQsaqopxln4E/fIiX+iSDe2/5U/Ng1ej9
 t153HDa+HXCpdSdZij5lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:urONgZvx36Y=;odYUgcjr5jEddrYUA4NMNTTaz3y
 /favZXaPVA0g/hltOM9NeMQdoSrAWq9awETCyUUuPiiTXN/9w8BtlNMAfhA+KYdhdZltLm2/E
 RgAvF+kgjfcALcq6+g4+Z1qmpdk/6bSMBSqzPyHWkt2UzKdai+Q2NtDhlqitlpLHeK8cNUAxo
 iLopG3iKBiIVURbbsy2tNYwZ4H6fuva9wbroA7ETMBGegLMkbpCMN7KpWHrr188Sxj2KPuL3R
 JuLJwZ868m5fX1/+Mvg/Uy7kgfLKySnwwjpc4yuBIVKENInjarQkuf8Mqe/vsnETMQwBGu2rA
 h9FnmST73LkMEWY+CnPzvGF+UmA1pzclPB+AGSQgwCKD1uG13sDKvOlzixHJid/0ET+Lo/pwm
 8I0RCuvsh3bcnY065G032O+PuaxojtpJieDTOqCoDpUw3Zi6RvipjcWQIHUHkXF9KWkVXib6o
 wAAdkD8ZhibAr0pTFag0rXE20LG9iXOWYP9gi1x2NpUrkKxhpUUd3oKZwXHbfw0PXfQ/FEsRr
 eh1CM42kGYKNEwnSCzy+72tKxVOY5UJHodjJoZCRIShybVzQvLwy3b2FR5qVWbnq5WmMcsgN0
 DlbOyZRXNRmLm/SUsdLblQ9GqcsyqJkAuHy1F0Doo3uHM0nuA9bBF60ABXJyEiHUPO/SSbdT0
 mftjH2MImwTNklsRiKqCEcMfCTBWeG9LEbMcQRu5q1jSXR5+98WHvjEnnCbZbefIjXGTxGRMR
 AI/P5pv8pN1gm8wsHinIRADTjd5/0qzxBD4arFGvUaFAEmvh5b9Kh51w7/6RMLPDTvdpYah8T
 vCpYCkjENS7oKNBjIKKyMDXA==

>> =E2=80=A6
>>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>>
>> Does anybody care more for the applicability of such information?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10#n398
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/researcher-guidelines.rst?h=3Dv6.10#n5
>
> Feel free to ignore Markus, he has a long history of sending
> unhelpful review comments and continues to ignore repeated requests
> to stop.

This seems to be another automated response which does not take meaningful=
 facts
into account (as intended).
Further collateral evolution might become more interesting.

Regards,
Markus

