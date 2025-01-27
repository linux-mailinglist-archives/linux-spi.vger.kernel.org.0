Return-Path: <linux-spi+bounces-6512-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7397A1DBC1
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2025 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152831882FC5
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2025 18:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B517C21B;
	Mon, 27 Jan 2025 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vMhuLTt9"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F117B505
	for <linux-spi@vger.kernel.org>; Mon, 27 Jan 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000837; cv=none; b=Ne4mIW9W4x1zCFS6o5NY58mRy0cPZJwkoHTdOWyiD9MB7yN1huDpRa89HK2E/uxpjRMmD0UFan8dBhPSmR8O460Gk1K1a8IoBxJivAwAjGuB994fHNH26f+mRyxX6Lch3VRY0F7TNzd/k10xNnSlHroERc8erlzKbVUHj+wITbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000837; c=relaxed/simple;
	bh=/xFRDq/2vwCvymGSfdoLId8wVkRDEO8hZUJkiCT0Yg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiphrerRM4uKMEVG6FfkL2yBNdmm9S3U9fq7qq2sYAzvRgrGfNWp5N7k4R8x5/08v73gPI40oZ1cDaOEa/+38VdbwKCo2VkqDn8CSrOCOMIvmw3sXqhqbr9UucBYNqmKdzoSjQBYLWecSzWSN/g3/p2l4fqtO0D8drs51ROPEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vMhuLTt9; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <50370a62-2e5e-45de-888f-ef3d1bfbb482@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738000818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8Ru8ILQt5YFwEkLQVtu+jlM11XhzHTarqvoBjmEMYo=;
	b=vMhuLTt9/XtylOqFAAaifb88drjAdXo0hXinvRFeza0t+LZYsthkZP9Gb987JhA+1/3api
	N+YiH+hc9iA6eLVCqENqySAKqYDLQq6lTvoE8ewlD//CoW5xnrJIEy/3eMcU5dDeQQ/DEz
	cbHLRoq6oM+7OWLqg2B1EfwpNuF+UBA=
Date: Mon, 27 Jan 2025 13:00:14 -0500
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
 <34e84bd2-381b-4f3e-99e1-92f7a878ed15@linux.dev>
 <20250127175752.GA511180-robh@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250127175752.GA511180-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/27/25 12:57, Rob Herring wrote:
> On Thu, Jan 23, 2025 at 05:57:41PM -0500, Sean Anderson wrote:
>> On 1/23/25 17:45, Rob Herring wrote:
>> > On Fri, Jan 17, 2025 at 11:12:15AM -0500, Sean Anderson wrote:
>> >> On 1/17/25 02:14, Michal Simek wrote:
>> >> > 
>> >> > 
>> >> > On 1/16/25 23:55, Sean Anderson wrote:
>> >> >> Add a reset to help recover from cancelled operations.
>> >> >>
>> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> >> >> ---
>> >> >>
>> >> >>   Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 ++++++
>> >> >>   1 file changed, 6 insertions(+)
>> >> >>
>> >> >> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>> >> >> index 04d4d3b4916d..901e15fcce2d 100644
>> >> >> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>> >> >> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>> >> >> @@ -36,12 +36,16 @@ properties:
>> >> >>     power-domains:
>> >> >>       maxItems: 1
>> >> >>   +  resets:
>> >> >> +    maxItems: 1
>> >> >> +
>> >> >>   required:
>> >> >>     - compatible
>> >> >>     - reg
>> >> >>     - interrupts
>> >> >>     - clock-names
>> >> >>     - clocks
>> >> >> +  - resets
>> >> > 
>> >> > In 2/5 you are calling devm_reset_control_get_optional_exclusive() that's why I expect reset is not really required property.
>> >> 
>> >> It's optional for the driver for backwards compatibility. But for the
>> >> devicetree we make it mandatory since it should be included in all new
>> >> devicetrees.
>> > 
>> > Generally, we discourage new required properties as that's an ABI 
>> > change. The exception is really when optional was a mistake. That's 
>> > arguably the case here if the h/w always has a reset.
>> 
>> This device has a reset on ZynqMP and Versal.
>> 
>> The driver still considers this property optional, so it's not an ABI break.
>> But I made it required in the schema to help out the folks at AMD when they
>> get around to upstreaming the Versal devicetree :)
> 
> Not 'the driver', but 'a driver'. You can't say what *all* drivers do. 
> If I write a new driver and read the schema, then I can say 'resets is 
> required so I'll make it required in my new driver'. But then my new 
> driver doesn't work with an older DT that didn't have resets which was 
> valid at the time.

OK, I'll add a description to this effect. The humans can read that, and
the machines won't care.

--Sean

