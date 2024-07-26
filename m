Return-Path: <linux-spi+bounces-4014-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42693D8E6
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2024 21:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236AAB210A9
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2024 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D273BBF4;
	Fri, 26 Jul 2024 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="seZDzk5Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A8E38DEE
	for <linux-spi@vger.kernel.org>; Fri, 26 Jul 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021425; cv=none; b=QESsr9+yT2+dJ9ZrRqhzp2UTBBi9iOLjmbwe0kFFlY1Esi6JbcKqb0G7JyOBr55o6mxgrPm4OdwejwlJpO+icwwq9FAyZry1hgTh3rnrnDODUWdCXNjJJBMiUlcdhETlxrqnnmfs9iE6ulYhxzYAS2KgDFu/k6zThbRH7mfOvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021425; c=relaxed/simple;
	bh=5I8TDqT8gwa2dtnPuQk5EvL4jvANgXjxbb41CCLtgfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFWKgvk5NivCl7b4rf3VXFtTZQ1gKWpOBqya7JVVhL2OmOEscUiBA8uXAUpN7IGFDnXCsjtOWwN9IyxpkeHo1cLGgVPP1fCyaYBoXSBJ4/u+d1NnjsQUIVaNLMRoohYREd3ii2RWdBa41729bBFZRfGNeJgO5oBXAModzJxcARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=seZDzk5Q; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-260e12aac26so1054152fac.0
        for <linux-spi@vger.kernel.org>; Fri, 26 Jul 2024 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722021422; x=1722626222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3s23lfRVw0JnayyoCgMBNHWTryj42pWvQjo3hMq56bk=;
        b=seZDzk5QEYJEn+rhgG7ZqGLmZ1VLd+OSyifyjRdvVoyNN9CR24m5o/kyYl4vR7my2A
         WZdenMVABzYTijtMximZLpBzMCjPqeNyfN6y8b1oUyWSmWkUXBuvnakNTtKfAVEqZZTR
         4aJD1bZLvBMfaJvrRGxNySvFkBldy/SlyHQKu1VPOSsk4AAmOliZ20tP09CwWRUo4nph
         GEHeJRe+EXM6+N/F8OYWfX/M6vQNvMRo51lr7AI4ld+lf7evRkGLelAegKAeJpziSHHr
         cLneiekC72yQOevvpiztnBnHRvPyMVc0NGLLdhwE1f92fsiBtGzI6Vu2z5SymTlQHGZ+
         CXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722021422; x=1722626222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s23lfRVw0JnayyoCgMBNHWTryj42pWvQjo3hMq56bk=;
        b=cxS/XSb7Unrb6zL9EsMZfZW1Iagzf/bYbmhcwVULdh9CikXIs81tL9DOCxhZLycfcc
         En/fPEGw1QNj+S//QLdROxoQag/jCg+bviNueBzvQZAEfnVJvBFxNfK3mAEoofasXqtY
         exsOHQdLCM47tdoONVG1wTzibfi5HMeH0aNVrFxs1iinrPXuyNGr/Ao1rWunBpl6qM/1
         WeI995PAZut0mne7ir0RDFWAGu80ytKmb5MFDzszGGDRsLNcsO0kzLZQtjI8kJL0r9c0
         OBwCkCKxvZj5QfKGi0KflgIL94iWdoDPrzYb1RETB6kA0G/UKegOgt0eerLSIgLq+oqo
         pPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVDnHKpIwQVSHKXKE2k4OFxAOQ0KT3hhmExtzgn+q/2KymjAcqseQYy5DG1+uYkgjcnLz6FPIOUjoL0m1jaymMWrVtJr+Q20pEu
X-Gm-Message-State: AOJu0YzoL3VICiSgDDg379RmlXRSAMKEjRAAzfgqitW84iACURMwaoIJ
	29yKOFREdXD/dLCVpGy954gF2WPX8/2rL7GqwmsmLlpEPU228kFT1aeVvBIw1gc=
X-Google-Smtp-Source: AGHT+IF0XA11UwhvqRFdKSWATudhXYz0A2IBpB+/45I1DC8giR/lZ3nfNRSAdGnI4vV3UyV7cO8xrw==
X-Received: by 2002:a05:6870:b48a:b0:262:32b0:dede with SMTP id 586e51a60fabf-267d4d16709mr992436fac.7.1722021422012;
        Fri, 26 Jul 2024 12:17:02 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2653e640030sm775424fac.16.2024.07.26.12.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 12:17:01 -0700 (PDT)
Message-ID: <9f57e41f-3534-4188-ae78-d323aa45e2a1@baylibre.com>
Date: Fri, 26 Jul 2024 14:17:00 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 5/9] spi: dt-bindings: axi-spi-engine: document
 spi-offloads
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <20240722-dlech-mainline-spi-engine-offload-2-v3-5-7420e45df69b@baylibre.com>
 <20240726123836.GA998909-robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240726123836.GA998909-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/24 7:38 AM, Rob Herring wrote:
> On Mon, Jul 22, 2024 at 04:57:12PM -0500, David Lechner wrote:
>> The AXI SPI Engine has support for hardware offloading capabilities.
>> There can be up to 32 offload instances per SPI controller, so the
>> bindings limit the value accordingly.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> RFC: I have a few questions about this one...
>>
>> 1.  The trigger-source properties are borrowed from the leds bindings.
>>     Do we want to promote this to a generic binding that can be used by
>>     any type of device?
> 
> I would make it specific to spi-offload.

OK

Meanwhile, we are working on some other ADCs (without SPI offload) and
finding that they are using basically the same sorts of triggers. And
on the driver side of things in this series, I'm getting feedback that
we should have some sort of generic trigger device rather than using,
e.g. a clk directly. If we need this same sort of trigger abstraction
for both SPI offloads and IIO device, it does seems like we might want
to consider something like a new trigger subsystem.

> 
>>
>> 2.  Some folks are working on adding DMA to TX stream support to the
>>     AXI SPI Engine hardware. I assume that the `dmas` property is like
>>     others where the order/index in the phandle array matters. So this
>>     would mean that for device that only uses 1 out of the 32 offloads
>>     and only uses 1 TX DMA channel, we would have to have 32 <0>s for
>>     each of the possible RX dmas in the array. Any way to do some kind
>>     of mapping to avoid this?
> 
> That's why -names exists.

OK

> 
>>
>> 3.  In v2, we discussed about having some sort of data processing unit
>>     between the AXI SPI Engine RX stream interface and the DMA channel
>>     interface on the DMA controller. I haven't included this in the
>>     bindings yet because we don't have a user yet. But it was suggested
>>     that we could use the graph bindings for this. So here is what that
>>     might look like:
>>
>>     Additional property for the AXI SPI Engine controller bindings:
>>
>>         out-ports:
>>             $ref: /schemas/graph.yaml#/properties/ports
>>             unevaluatedProperties: false
>>             patternProperties:
>>             "^port@1?[0-9a-f]$":
>>                 $ref: /schemas/graph.yaml#/properties/port
>>                 unevaluatedProperties: false
>>
>>     And this would be connected to a device node similar to this:
>>
>>         ip-block@3000 {
>>             // Something similar to, but not exactly like
>>             // http://analogdevicesinc.github.io/hdl/library/util_extract/index.html
>>             compatible = "adi,crc-check";
>>             // clock that runs this IP block
>>             clocks = <&sysclk 15>;
>>             // interrupt raised on bad CRC
>>             interrupts = <&intc 99>;
>>             interrupt-names = "crc";
>>             // output stream with CRC byte removed piped to DMA
>>             dmas = <&adc_dma 0>;
>>             dma-names = "rx";
>>
>>             port {
>>                 adc_crc_check: endpoint {
>>                     remote-endpoint: <&offload0_rx>;
>>                 };
>>             };
>>         };
>>
>>     Does this sound reasonable?
> 
> Shrug.
> 
> Unlike the offload which is internal to the controller driver?

Correct. And in the case of the AXI SPI Engine, the offload is
part of the controller IP block in hardware as well.

> isn't 
> this specific to the device because it needs to be aware of any 
> processing done or not done. Or maybe it wants to configure the 
> processing.

Yes, the SPI peripheral driver would be the one needing to know
what sort of data processing unit it is connected to so it knows
how to configure the chip and how to interpret the received data
or other signals from the data processing unit.

> 
> OTOH, maybe this isn't any different than offload?

Also true since the SPI peripheral needs to know what kind of
capabilities that the offload itself has.

> 
> Rob


