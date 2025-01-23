Return-Path: <linux-spi+bounces-6444-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395FA1ACF4
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2025 23:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B4E3A9739
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2025 22:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2147F1D47BB;
	Thu, 23 Jan 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UWMHVbsV"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF61D416E
	for <linux-spi@vger.kernel.org>; Thu, 23 Jan 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673070; cv=none; b=qCRxSz9HxlVLjmv2YdrLhYYadTt2wUQmZ4KgAWTnopSPrvrX5QRWtvi8sHeTla2x6eiWJSDDzPnM1unv2IN9Qe97+n8YveYWXBB4offU6nVuGO8RZp9t5alvGPQlL+Co2iJCMNtkZKO/Sn78eK9PyPbHQ8dWpAEUnRtDWTB6bIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673070; c=relaxed/simple;
	bh=htMDIByq1woBNL7OFpqdOd+0bwBsWd8J2ZgzIBXW89w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1ID/CK7qksV01gOKdBxa9Udgq69Mw4EeZEb1A7Hj+FGTeJOFyBBxV8n22SAjRHJ+w0Iriqkprac9k54tkwiWPRl3TJAlHLA9x9QZOiuiKLIEDsVK4gFL+dylic8ewP/I+fHUVSVYjDf1WpWMJIiycY3XAJuA5PEDsWEzZDmzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UWMHVbsV; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34e84bd2-381b-4f3e-99e1-92f7a878ed15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737673066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5vETblkns4myv0L36tnPYvQDxGkuxSXvQ+u+++b6uc=;
	b=UWMHVbsVeOqCg1tbtZ5magJB5bC76eSbbvBnvaJ0k5mWY3C/RUdQPQcisluKOJMIWkuiru
	QgzUcrPMpwhCrCi1seyFemiz6RO+s43G4LiZS0elucLnEDAu1i8WqdtYaW22T5ucw+KTGU
	bAF8FjTxdUqOh6VtYsckqRjXlUI104w=
Date: Thu, 23 Jan 2025 17:57:41 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] dt-bindings: spi: zynqmp-qspi: Add reset
To: Rob Herring <robh@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <20250116225521.2688224-2-sean.anderson@linux.dev>
 <8a0d8789-7a0d-42b7-9aff-e867c14db3c9@amd.com>
 <b8e63009-13fb-493f-adf6-4d30adbe9b1b@linux.dev>
 <20250123224520.GA456390-robh@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250123224520.GA456390-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/23/25 17:45, Rob Herring wrote:
> On Fri, Jan 17, 2025 at 11:12:15AM -0500, Sean Anderson wrote:
>> On 1/17/25 02:14, Michal Simek wrote:
>> > 
>> > 
>> > On 1/16/25 23:55, Sean Anderson wrote:
>> >> Add a reset to help recover from cancelled operations.
>> >>
>> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> >> ---
>> >>
>> >>   Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 ++++++
>> >>   1 file changed, 6 insertions(+)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>> >> index 04d4d3b4916d..901e15fcce2d 100644
>> >> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>> >> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>> >> @@ -36,12 +36,16 @@ properties:
>> >>     power-domains:
>> >>       maxItems: 1
>> >>   +  resets:
>> >> +    maxItems: 1
>> >> +
>> >>   required:
>> >>     - compatible
>> >>     - reg
>> >>     - interrupts
>> >>     - clock-names
>> >>     - clocks
>> >> +  - resets
>> > 
>> > In 2/5 you are calling devm_reset_control_get_optional_exclusive() that's why I expect reset is not really required property.
>> 
>> It's optional for the driver for backwards compatibility. But for the
>> devicetree we make it mandatory since it should be included in all new
>> devicetrees.
> 
> Generally, we discourage new required properties as that's an ABI 
> change. The exception is really when optional was a mistake. That's 
> arguably the case here if the h/w always has a reset.

This device has a reset on ZynqMP and Versal.

The driver still considers this property optional, so it's not an ABI break.
But I made it required in the schema to help out the folks at AMD when they
get around to upstreaming the Versal devicetree :)

> Unfortunately, there's not a way to distinguish 'required' from 
> 'required for new users'.

I will add a note to the commit message about this situation.

--Sean


