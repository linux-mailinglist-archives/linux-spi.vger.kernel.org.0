Return-Path: <linux-spi+bounces-5688-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29239C6B2E
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062C0281940
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124C61BD9E4;
	Wed, 13 Nov 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G2qmxmKc"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261A1BD028;
	Wed, 13 Nov 2024 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488834; cv=none; b=Xmq1dIpkh3vwLNveZtwPxP5YT7RRhbHWaAIZXIhMXMMjCOPk1Xysu01egUmniDfkrHS2ic0wuNMqNbOxHyhdAJHYTzdmr1RC+UCcC8UYh9MIvwBTZBYnIBltgtF319yOPYo4ft3cVsXzcp0VWNtLw8D5e45EXZcVzz0QIokvYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488834; c=relaxed/simple;
	bh=gItS4ct+EOxG20yTUb1Sp9O+9wuwU7KGiBD97mPueXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lTQEIeqsjmxEgngOEEofOT8PHykc5CRnwmc2lp+Cjvt0C1yq4qUh/r+xBTlxQN9kgfrZ7I5yB9rZl0EtbVR639ampY2DBMJj8ZEcnxMtmI0xa/vXNygVPCSzr418CBW4JisTWIpf8rDmH1e0mPOkMc8PKoc4DMAhfKdYUhgpZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G2qmxmKc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25131E0003;
	Wed, 13 Nov 2024 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731488829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gItS4ct+EOxG20yTUb1Sp9O+9wuwU7KGiBD97mPueXU=;
	b=G2qmxmKcMURoRlGS4cfajPcrtQ5kTfsrSA9Tm4QY2j0/8O3lfNfFlnAMvavJdzc/RgV5WJ
	ARZAP1h19/6Bno5A1TJ9YMJ3lSZFd3m4vDXS40nLndb88SyaKRqfWN7Pt0f6UUpXpwTXcA
	fzB/qbR6vNiBtgZSz54VVWhc9yq+o+PQPTGpP1LcCGboKqPThjB307C3cNoK9Tz5YZqEkl
	25Ym2aJ5A0mpMIg6I3YAbgtaIS3MgL+7suC8spzmARmiy719+lN7aQnyLQXIX7Cqj1SAl9
	stL+IE1slGPQxlrDBQeTDTOztDw1rPDAczn33twZvcqOzT2Brq0KlEbNJvNyZg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <andersson@kernel.org>,
  <konradybcio@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <manivannan.sadhasivam@linaro.org>,  <linux-arm-msm@vger.kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <quic_srichara@quicinc.com>,  <quic_varada@quicinc.com>
Subject: Re: [PATCH v13 2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
In-Reply-To: <374ea155-0970-38bd-470f-cc440ca0bab5@quicinc.com> (Md Sadre
	Alam's message of "Tue, 12 Nov 2024 17:45:07 +0530")
References: <20241030121919.865716-1-quic_mdalam@quicinc.com>
	<20241030121919.865716-3-quic_mdalam@quicinc.com>
	<871pzh397j.fsf@bootlin.com>
	<374ea155-0970-38bd-470f-cc440ca0bab5@quicinc.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 13 Nov 2024 10:07:08 +0100
Message-ID: <87bjyjsds3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 12/11/2024 at 17:45:07 +0530, Md Sadre Alam <quic_mdalam@quicinc.com> wr=
ote:

> On 11/12/2024 12:00 AM, Miquel Raynal wrote:
>> On 30/10/2024 at 17:49:13 +0530, Md Sadre Alam <quic_mdalam@quicinc.com>=
 wrote:
>>=20
>>> cleanup qcom_nandc driver as below
>> Perform a global cleanup of the Qualcomm NAND controller driver with
>> the
>> following improvements:
> Ok
>>>
>>> - Remove register value indirection api
>> API
> Ok
>>=20
>>>
>>> - Remove set_reg() api
>> API
> Ok
>>=20
>>>
>>> - Convert read_loc_first & read_loc_last macro to function
>> functions
> Ok
>>=20
>>>
>>> - Renamed multiple variables
>> Rename
> Ok

In general when the main answer is "okay", you can probably just say a
sentence like "thanks for the comments I'll take them into account",
without answering to each and every comment. This way, it will be easier
for me to catch if you have further remarks.


Thanks,
Miqu=C3=A8l

