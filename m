Return-Path: <linux-spi+bounces-9244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF6EB1669C
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B19F1AA4D7B
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0F62E040D;
	Wed, 30 Jul 2025 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Av029LSt"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149B298CA0;
	Wed, 30 Jul 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901885; cv=none; b=RnmI0uh7GjX1SxH5i/M3qeKgGEFwU76gYXiMp82yRrmTEKZXtYsUWFI9OGKYCb2t/xd2zPOJ2RzwIPYJWklFoduXmohxHxX88+EgiVC+8qqP71ie+aqVmIvazCTgb9igT3dRL6hmJ5Y4AAeu7wm1GyrwPq84gL6gM8UtFyEw0a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901885; c=relaxed/simple;
	bh=rlWVA98Nk1xc9d+D4b6/PtmU0tfeo27zyN8Zmh0ftUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jk1qu2k/B0poAze8S2vxdWV1imgILTlhoMqbVpAKUJYznCYhx+FHrzJXPKNUpnpfQVr765JBpS4wGKKn9g+0eAukmo9LYKeeWc+USVu73XA8bhaVImmvIP1gWtfe1IKvUelRkATlQrkhx4COgEfe1/wZ0b6MZGY1vQDzQDWOgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Av029LSt; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UIUoFW3307285;
	Wed, 30 Jul 2025 13:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753900250;
	bh=YGLAgUEXl2AFMUcOtsvCV8sTSwdu2o3sUFAfa7+mU18=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Av029LSttexiKGknZLD4eSnqX/OfVeyNtZeiJrajkm1c+Bg1fT9h2RULAV6DZNgPO
	 8BFPEMgi0Otm1f+uIVM+OofEy9WO3BvKRF3n5e7rJqPJUz29PuzBoVNBapEDCGiKFX
	 Alaqtju5y44PamwXpGdIy/PdGNK1ah8hqMlpwOsk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UIUotF3664115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 30 Jul 2025 13:30:50 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 13:30:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 13:30:49 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UIUnBh1678461;
	Wed, 30 Jul 2025 13:30:49 -0500
Message-ID: <e0383654-ebb5-4b83-8820-bc7eb148f4a7@ti.com>
Date: Wed, 30 Jul 2025 13:30:49 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] devicetree: bindings: spi: Introduce SPI bus
 extensions
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>
CC: Ayush Singh <ayush@beagleboard.org>, Mark Brown <broonie@kernel.org>,
        <herve.codina@bootlin.com>, <conor+dt@kernel.org>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Deepak Khatri <lorforlinux@beagleboard.org>,
        Dhruva Gole <d-gole@ti.com>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
 <20250729-spi-bus-extension-v1-4-b20c73f2161a@beagleboard.org>
 <c65d26d0-51b8-4131-a755-6c72b7dea549@kernel.org>
 <20250730174553.4df8037b@booty>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250730174553.4df8037b@booty>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 7/30/25 10:45 AM, Luca Ceresoli wrote:
> On Tue, 29 Jul 2025 14:52:00 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 29/07/2025 11:51, Ayush Singh wrote:
>>> An SPI bus can be wired to the connector and allows an add-on board to
>>> connect additional SPI devices to this bus.
>>>    
>>
>> ... so I found the binding. Not marked by my filters due to non-standard
>> subject.
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching. For bindings, the preferred subjects are
>> explained here:
>> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>>
>>> Those additional SPI devices could be described as sub-nodes of the SPI
>>> bus controller node however for hotplug connectors described via device
>>> tree overlays there is additional level of indirection, which is needed
>>> to decouple the overlay and the base tree:
>>>
>>>    --- base device tree ---
>>>
>>>    spi1: spi@abcd0000 {
>>>        compatible = "xyz,foo";
>>>        spi-bus-extension@0 {

Could we make this more generic so it doesn't need to be specific to each
type of node/bus? The core goal IIUC is to keep some parts of the node
out in another node, but have the contents act as if they were part of the
first node. So how about "node-extension", or if we only need one direction
links from the second node, "node-extends", something like this:


--- base device tree ---

spi1: spi@abcd0000 {
     compatible = "xyz,foo";
     #address-cells = <1>;
     #size-cells = <0>;
     node-extensions = <&spi_sensors>;
}

connector {
     spi_sensors: spi-sensors {
         eeprom@50 { compatible = "atmel,24c64"; ... };
     };
};

Or if we want to keep the base device node untouched (this would be my
preference as otherwise we would have to add modifications in more places):

--- base device tree ---

spi1: spi@abcd0000 {
     compatible = "xyz,foo";
     #address-cells = <1>;
     #size-cells = <0>;
}

connector {
     spi_sensors: spi-sensors {
         node-extends = <&spi1>;
         eeprom@50 { compatible = "atmel,24c64"; ... };
     };
};

In either case, the content of the "spi-sensors" node (i.e. eeprom@50)
acts in all ways as if that was directly inside the "spi1" node.

This should provide the separation you are looking for and be generic for
*any* node's use. The base OF support could be extended so that functions
like for_each_available_child_of_node() and property fetching handle
this transparently. That way you don't need to go make modifications
to each and every bus and driver that accesses the contents of nodes
to handle these node extensions.

>>>            spi-bus = <&spi_ctrl>;
>>>        };
>>>        ...
>>>    };
>>>
>>>    spi5: spi@cafe0000 {
>>>        compatible = "xyz,bar";
>>>        spi-bus-extension@0 {
>>>            spi-bus = <&spi_sensors>;
>>>        };
>>>        ...
>>>    };
>>>
>>>    connector {
>>>        spi_ctrl: spi-ctrl {
>>>            spi-parent = <&spi1>;
>>>            #address-cells = <1>;
>>>            #size-cells = <0>;
>>>        };
>>>
>>>        spi_sensors: spi-sensors {
>>>            spi-parent = <&spi5>;
>>>            #address-cells = <1>;
>>>            #size-cells = <0>;
>>>        };
>>>    };
>>
>> It looks like you are re-doing I2C work. Please wait till I2C discussion
>> finishes, so we won't have to comment on the same in multiple places.
>>
>>>
>>>    --- device tree overlay ---
>>>
>>>    ...
>>>    // This node will overlay on the spi-ctrl node of the base tree
>>>    spi-ctrl {
>>>        eeprom@50 { compatible = "atmel,24c64"; ... };
>>>    };
>>>    ...
>>>
>>>    --- resulting device tree ---
>>>
>>>    spi1: spi@abcd0000 {
>>>        compatible = "xyz,foo";
>>>        spi-bus-extension@0 {
>>>            spi-bus = <&spi_ctrl>;
>>>        };
>>>        ...
>>>    };
>>>
>>>    spi5: spi@cafe0000 {
>>>        compatible = "xyz,bar";
>>>        spi-bus-extension@0 {
>>>            spi-bus = <&spi_sensors>;
>>>        };
>>>        ...
>>>    };
>>>
>>>    connector {
>>>        spi_ctrl: spi-ctrl {
>>>            spi-parent = <&spi1>;
>>>            #address-cells = <1>;
>>>            #size-cells = <0>;
>>>
>>>            device@1 { compatible = "xyz,foo"; ... };
>>>        };
>>>
>>>        spi_sensors: spi-sensors {
>>>            spi-parent = <&spi5>;
>>>            #address-cells = <1>;
>>>            #size-cells = <0>;
>>>        };
>>>    };
>>>
>>> Here spi-ctrl (same goes for spi-sensors) represent the part of SPI bus
>>> that is on the hot-pluggable add-on. On hot-plugging it will physically
>>> connect to the SPI adapter on the base board. Let's call the 'spi-ctrl'
>>> node an "extension node".
>>>
>>> In order to decouple the overlay from the base tree, the SPI adapter
>>> (spi@abcd0000) and the extension node (spi-ctrl) are separate nodes.
>>>
>>> The extension node is linked to the SPI bus controller in two ways. The
>>> first one with the spi-bus-extension available in SPI controller
>>> sub-node and the second one with the spi-parent property available in
>>> the extension node itself.
>>>
>>> The purpose of those two links is to provide the link in both direction
>>> from the SPI controller to the SPI extension and from the SPI extension
>>> to the SPI controller.
>>>
>>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>>> ---
>>>   .../devicetree/bindings/spi/spi-controller.yaml    | 66 +++++++++++++++++++++-
>>>   1 file changed, 65 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
>>> index 82d051f7bd6e09dab9809c85ff13475d2b118efd..9b44ce4542f9552c94cb0658ffe3f6d3f29bc434 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
>>> @@ -25,6 +25,13 @@ properties:
>>>     "#size-cells":
>>>       const: 0
>>>   
>>> +  spi-parent:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      In case of an SPI bus extension, reference to the SPI bus controller
>>> +      this extension is connected to. In other word, reference the SPI bus
>>> +      controller on the fixed side that drives the bus extension.
>>> +
>>>     cs-gpios:
>>>       description: |
>>>         GPIOs used as chip selects.
>>> @@ -111,7 +118,26 @@ properties:
>>>         - compatible
>>>   
>>>   patternProperties:
>>> -  "^.*@[0-9a-f]+$":
>>> +  'spi-bus-extension@[0-9a-f]+$':
>>> +    type: object
>>> +    description:
>>> +      An SPI bus extension connected to an SPI bus. Those extensions allow to
>>> +      decouple SPI busses when they are wired to connectors.
>>
>> I really do not get why you need separate two-way phandles for marking
>> parent child relationship. IOW, if you need two way, then why not graphs?
>>
>> Or why not just making the device@2 a child of SPI, since it is coming
>> from overlay.
> 
> For the same reason as in I2C (and the proposed solution is the same).
> 
> As you wrote above, Ayush could wait for the I2C discussion to finish.
> Problem is, the I2C discussion is not moving forward: Hervé is sending
> proposals but there is no feedback on the core of the proposal, and no
> feedback at all on the latest iteration. In case your filters missed it:
> https://lore.kernel.org/all/20250618082313.549140-1-herve.codina@bootlin.com/
> 

That series didn't end up in my mailbox for some reason, so replying
here, but my response above should apply to both I2C and this SPI series
just the same.

Andrew


