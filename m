Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE336EE1B
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhD2Q3C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 12:29:02 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55801 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhD2Q3B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Apr 2021 12:29:01 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9968222173;
        Thu, 29 Apr 2021 18:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619713693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgbDNNHtI08G/Bd19jixZ4ooSityYmie7rX0EBgQRDk=;
        b=kBkA5zcgkuCUSwxygLw883KezMw5l+6jZDLjPTXG4h5DhGO07rPZzP9g/4/bneXr4TwxYe
        mvYjvRkrqAnBgc/4zpAKv5h0/QMnaAMzLaXx48OhAYsI8+wfbSrjNd38WkpQm+rB2ig2Jj
        Yh/d9aXzSJqDTANxVBEMIobGc119c3Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Apr 2021 18:28:13 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor.Ambarus@microchip.com, nm@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, lokeshvutla@ti.com
Subject: Re: [RFC PATCH 4/6] spi: cadence-qspi: Use PHY for DAC reads if
 possible
In-Reply-To: <20210312101757.sqeyledbwjnpqdoy@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-5-p.yadav@ti.com>
 <2f26456e-59ff-2625-5d65-c1537052839d@microchip.com>
 <20210312101757.sqeyledbwjnpqdoy@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <ee2b753b16e76ecbede4c1373b6f2d77@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-03-12 11:17, schrieb Pratyush Yadav:
> On 12/03/21 09:13AM, Tudor.Ambarus@microchip.com wrote:
>> On 3/11/21 9:12 PM, Pratyush Yadav wrote:
>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> >
>> > Check if a read is eligible for PHY and if it is, enable PHY and DQS.
>> 
>> DQS as in data strobe? Shouldn't the upper layer inform the QSPI 
>> controller
>> whether DS is required or not?
> 
> Yes, DQS as in data strobe. I need to check this again, but IIRC the
> controller cannot run in PHY mode unless DS is used. Ideally the upper
> layer should indeed inform the controller whether DS is 
> supported/in-use
> or not. That can be used to decide whether PHY mode (and consequently
> the DS line) is to be used or not.
> 
> Currently there are only two flashes that use 8D-8D-8D mode (S28HS512T
> and MT35XU512ABA), and both of them drive the DS line.

The LS1028A datasheet explicitly states that the calibration is only
used for non-DQS flashes. Which makes sense, because it just determine 
at
which point the input data is sampled. And if the flash provides a data
strobe, it already know when to sample it. What I am missing here?

-michael
