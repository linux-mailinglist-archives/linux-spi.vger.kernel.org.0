Return-Path: <linux-spi+bounces-3655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D202F91B72A
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 08:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524D61F25050
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 06:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E7A54662;
	Fri, 28 Jun 2024 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="xujbwfzG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5496F2E2
	for <linux-spi@vger.kernel.org>; Fri, 28 Jun 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556321; cv=none; b=LBj2CM2BZSg2f2RULTXt7bS/l1TEQ1B9jFFkcPyObPGiNO/GA8QnGnX2I/kEg3IKogzeYjq/BhCcofB/1ljJKyEmJkzpzBbrc/MNJi0KNdT4HGspnp8gKqIBRGDTCcod69jJXdNGxJZKQHBVQx/nWpUreCJfqnpxZOPRbGyGYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556321; c=relaxed/simple;
	bh=aX//4o/Tq4Tz+SaoAGwZ7f5tQ5wwCCxE3I4G6vcuH0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cf4tBHaKMI2RT0LUuwQUXHkg7dH7o0xSrYxYb1tHhi78dc8E8i39IgpE5XI4t9PwoAAg9mfbhm1J1dc3Va3NmGB1ZVX8LqjRhGqNr6K6pCPaLd8cQxEn7GywwoIbTVKjjBSKB0TyKr9o26UEOVJbN3bZ6mGVD/tusAdwFsiiz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=xujbwfzG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa782ff72aso47195ad.0
        for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 23:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719556319; x=1720161119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1rocusKmAnlUOu+jeOdiCmd2Vg30LydUcfBNbSGYx0=;
        b=xujbwfzGYL3OfdTErrN40dcUKy0qpXlEoKFCtqnsxLYdAs1LQus3s1axVqX/H4mP5C
         7mAswgqJ4jJ1mVf6h52GOwSfwFbqfKC8KP3civchqcZiZNseyVy84brW4VidzEztkDfb
         Mwf8AlOspRV3HJFL6gAu0Ll2cspeOCOq0Pff0Veps9QKl4BNatG+mSea3l0Qn8VsakUF
         JJ67ktWWJASVkOvT2itYA4hcGR+4DEfEAdIJSJwJLNWT/p7YICcW8yfnfK20pilYFBU+
         L2pNCWG5+olw6JbuDx+UhMUEEbRIGCQxXEchO8ikHtbbX+C23CXWgJFUElcuVDBueQx8
         +RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556319; x=1720161119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1rocusKmAnlUOu+jeOdiCmd2Vg30LydUcfBNbSGYx0=;
        b=YjHA/Bekon6TWSO8oQ5nbFmt2ilSGp6pUh0PECGipImJPGqgSMsjPp1iP+grxDi4Kd
         /AmB3fWUAo4F3Q0GloRvUySqcciSOaxAjA7RL4zMj/GYyuxGGPY1lAB7P4whGLRrNZ9E
         2EUUNrZh2ymKzSEEljLUKHRUT+PHV6F2ferSd9rxHHUtdhAXLDCLm90HSz6VAsW8036U
         PnE6nQrf50r3CgmLSeLstVIGuC9BbJe9hAZPvDuUg89MqT/OIgOXCAcC1RwmtrVl3RsP
         jWJ60B8ayj3OImlHc7k8OEO3DN9L7OW9b9+Rqn3i6Ksqd+FIouotsLowfLN+OCg0Wwlu
         KnHg==
X-Gm-Message-State: AOJu0Yx3y4u3Wcus5EuZIaDBp1sxVKa8WzaVnaBRNqzHdhN/sEJpm5Wc
	mSCmh9rJhg0YhKfwTI9cF+Wy4mWGXXvY7DXlI+moebfzVnzMLsj+UlwOnyoPVg==
X-Google-Smtp-Source: AGHT+IFcxfyCEs2tEm+0lAKNbpfgXmBQL9yXbPzPjqzGe4rSBB1rmH9O8H9n1tmBPnBxymCV2u50MA==
X-Received: by 2002:a17:902:e54e:b0:1f9:b19b:4255 with SMTP id d9443c01a7336-1fa0d817757mr199471545ad.4.1719556318653;
        Thu, 27 Jun 2024 23:31:58 -0700 (PDT)
Received: from ?IPV6:2401:4900:53e1:8b89:31db:554e:9fb2:8c06? ([2401:4900:53e1:8b89:31db:554e:9fb2:8c06])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c7067sm7808945ad.51.2024.06.27.23.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 23:31:58 -0700 (PDT)
Message-ID: <1edcfd98-e73c-477e-a4ce-98cb41e66ab6@beagleboard.org>
Date: Fri, 28 Jun 2024 12:01:47 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] misc: Add mikroBUS driver
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Vaishnav M A <vaishnav@beagleboard.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 jkridner@beagleboard.org, robertcnelson@beagleboard.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ayush Singh <ayushdevel1325@gmail.com>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/24 21:56, Ayush Singh wrote:

> MikroBUS is an open standard  developed by MikroElektronika for connecting
> add-on boards to microcontrollers or microprocessors. It essentially
> allows you to easily expand the functionality of your main boards using
> these add-on boards.
>
> This patchset adds mikroBUS as a Linux bus type and provides a driver to
> parse and register the mikroBUS board using device tree infrastructure.
>
> The patchset is based on work originally done by Vaishnav.
>
> Link: https://www.mikroe.com/mikrobus
> Link: https://docs.beagleboard.org/latest/boards/beagleplay/
> Link: https://lore.kernel.org/all/20240317193714.403132-1-ayushdevel1325@gmail.com/ Patch v4
>
> Changes v5
> - Complete rewrite to use device tree instead of mikroBUS manifest.
> - Only support for SPI.
> - Adds `mikrobus,spi` compatible property.
>
> Changes v4:
> - Better commit messages
> - Remove clickID, serdev, pwm, regulator, clocks etc. Just the basic
>    mikroBUS driver.
> - Fix a lot of memory leaks, unused variables, etc.
> - Create accompanying PR in Greybus Spec repository
> - Switch to 80 columns formatting
> - Some other fixes pointed out in v3
>
> Changes in v3:
> - Use phandle instead of busname for spi
> - Use spi board info for registering new device
> - Convert dt bindings to yaml
> - Add support for clickID
> - Code cleanup and style changes
> - Additions required to spi, serdev, w1 and regulator subsystems
>
> Changes in v2:
> - support for adding mikroBUS ports from DT overlays,
> - remove debug sysFS interface for adding mikrobus ports,
> - consider extended pin usage/deviations from mikrobus standard
>    specifications
> - use greybus CPort protocol enum instead of new protocol enums
> - Fix cases of wrong indentation, ignoring return values, freeing allocated
>    resources in case of errors and other style suggestions in v1 review.
>
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
> Ayush Singh (7):
>        dt-bindings: connector: Add mikrobus-connector
>        dt-bindings: mikrobus: Add mikrobus board base
>        dt-bindings: mikrobus: Add mikrobus-spi binding
>        spi: Make of_find_spi_controller_by_node() available
>        spi: Make of_register_spi_device() available
>        mikrobus: Add mikroBUS driver
>        dts: ti: k3-am625-beagleplay: Add mikroBUS
>
>   .../bindings/connector/mikrobus-connector.yaml     | 107 ++++++
>   .../bindings/mikrobus/mikrobus-board.yaml          |  20 ++
>   .../devicetree/bindings/mikrobus/mikrobus-spi.yaml |  37 +++
>   MAINTAINERS                                        |   9 +
>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |  94 +++++-
>   drivers/misc/Kconfig                               |  16 +
>   drivers/misc/Makefile                              |   1 +
>   drivers/misc/mikrobus.c                            | 361 +++++++++++++++++++++
>   drivers/spi/spi.c                                  | 209 ++++++------
>   include/linux/spi/spi.h                            |   7 +
>   10 files changed, 750 insertions(+), 111 deletions(-)
> ---
> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> change-id: 20240627-mikrobus-scratch-spi-ad8c98dcec98
>
> Best regards,


I would just like to summarize the discussions on different patches here 
to give information regarding why the board is not subnode of 
mikrobus-connector along with what questions need to be answered for a 
subnode based architecture.

I will be using (```) to differentiate between code section and non-code 
section. It is just for seperation not for any formatting since I am 
using plaintext.


Let me first summarise the goals that should be possible with any 
architecture chosen.

1. Keeping the device tree properties upstream in a system independent way.

2. Editing system dt at kernel build time to add the pre-defined board 
or applying dt overlay using uboot or dynamic overlays.

3. Allowing creation of sysfs entries `new_device` and `delete_device` 
similar to what already exists for I2C, etc.

4. Allow using 1-wire-eeprom in a fashion that allows automatic board 
discovery.


Let me now introduce the 2 architectures we will be discussing:

1. mikrobus-connector has phandle to mikrobus-board:

```

\ {

     connector1 {

         board = <&board1>;

     };


     mikrobus_boards {

         board1 {

             ...

         };

     };

};

```


2. mikrobus board is a child node of mikrobus-connector:

```

\ {

     connector1 {

         ...

         spi {

             board1 {

                 ...

             };

         };

     };

};

```


I will now go over how each of these goals might look like in both of 
the architecture.

1. Keeping the device tree properties upstream in a system independent way:

a. mikrobus-connector has phandle to mikrobus-board

It is possible to create an overlay as follows which will work with any 
system that defines the `mikrobus_boards` node. This node is completely 
independent of mikroBUS connector and thus does not need to be rewritten 
(or generated) for each board. There are no problems for system with 
more than 1 mikrobus connector.

```

&mikrobus_boards {

     board2 {

         ...

     };


     board3 {

         ...

     };

};

```


b. mikrobus board is a child node of mikrobus-connector:

Not sure how to do something similar here. The overlay needs to be 
rewritten (or generated) for each board. Systems with multiple mikrobus 
connectors will need multiple overlays adding the boards as child node 
of each connector (with status = "disabled"). Considering how many 
mikrobus boards are available, this can also lead to problem (especially 
in embeded Linux) with the dt binary size since each connector is 
replicating the same overlay.

```

&connector1 {

     spi = {

         board 2 {

             ...

         };

         board 3 {

             ...

         };

     };

};


&connector2 {

     spi = {

         board 2 {

             ...

         };

         board 3 {

             ...

         };

     };

};

```

Maybe it is possible to have special behavior for mikrobus-connector 
nodes in dt overlay but that will break compatibility with exisiting 
infrastructure which isn't great.


2. Editing system dt at kernel build time to add the pre-defined board 
or applying dt overlay using uboot or dynamic overlays.

a. mikrobus-connector has phandle to mikrobus-board

```

&connector1 {

     board = <&board1>;

};

```


b. mikrobus board is a child node of mikrobus-connector:

```

&connector1 {

     spi = {

         board 2 {

             ...

         };

     };

};

```

Both the cases will need to generate these overlays at build time. 
However, in case (a), the overlay will be much smaller than case (b). 
This is important for embeded Linux.


3. Allowing creation of sysfs entries `new_device` and `delete_device` 
similar to what already exists for I2C, etc.

a. mikrobus-connector has phandle to mikrobus-board

It is quite simple with the current changeset APIs. I have an example 
implementation here: 
https://github.com/Ayush1325/linux/blob/c4e3d5138b7ad5c24bdbc1dd02d89720d3a5de82/drivers/misc/mikrobus.c#L59 
.

Essentially, it is possible to pass the mikroBUS board name or id to 
create changeset as long as the board has been defined in dt. The boards 
definition can be added using overlay in uboot of dynamic overlays using 
configfs patch.


b. mikrobus board is a child node of mikrobus-connector:

Since even the board definition overlay is now dependent on the 
connector, any person writing the board overlay needs to know the name's 
of the connector nodes and generate overlays for all connectors. We can 
toggle a `status` property to `okay` based on the board id passed 
through sysfs.


4. Allow using 1-wire-eeprom in a fashion that allows automatic board 
discovery.

a. mikrobus-connector has phandle to mikrobus-board

1-wire-eeprom only needs to contain the board definition overlay which 
is not dependent on the connector. The connector can generate the 
changeset of add `board` property to itself. The board should work 
irrespective of if the dt overlay is actually present in the kernel 
config since we can read the overlay from 1-wire-eeprom and apply it 
using `of_overlay_fdt_apply()`.


b. mikrobus board is a child node of mikrobus-connector:

Cannot really use the normal dt overlay. Maybe we can use the mikroBUS 
manifest to dynamically create the overlay, but well, I do not wish to 
support both the manifest and devicetree at the same time.

Maybe we can introduce something like partial device tree which only 
contains properties to be applied to a target device node? Since 
`of_overlay_fdt_apply` does contain target node property, maybe it is 
already possible to have an overlay that is generic over a type of node 
instead of the exact node?


I will also go through the overlay kernel internals to see if there are 
any better ways to use child-nodes. Feel free to chime in if you have 
any ideas.


Yours Sincerely,

Ayush Singh


