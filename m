Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE60933DB39
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 18:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhCPRqS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 13:46:18 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:59151 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbhCPRpv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 13:45:51 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9348F22238;
        Tue, 16 Mar 2021 18:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615916749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0IPrSvHYfb2D9+Dd0sH+zRB2NKqcmSi14A5U5gAz1U=;
        b=vZPeLHy6uNVuYY2qpX/N+aK0vmnYAv16QOqug9shJdIwhIQhfGZ5hPdSipGLf66uqrWM3Y
        SQN9TmxaDkOgIBYObE3YJf/ggiqo6eeISSs02/yDfOPyKQCvBWVnAleFs2UzZxV6KJpNg2
        kMgVEKn3ieff9cHXxn0HGhn6RMmex74=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Mar 2021 18:45:49 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
In-Reply-To: <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <067c42f3726578ebe60d201a141dfdb6@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-03-15 19:30, schrieb Pratyush Yadav:

..
>> +patternProperties:
>> +  "@[0-9a-f]+":

Shouldn't this be "^.*@[0-9a-f]+$"?

>> +    type: object
>> +
>> +    properties:
>> +      fsl,spi-cs-sck-delay:
>> +        description:
>> +          Delay in nanoseconds between activating chip select and the 
>> start of
>> +          clock signal, at the start of a transfer.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +      fsl,spi-sck-cs-delay:
>> +        description:
>> +          Delay in nanoseconds between stopping the clock signal and
>> +          deactivating chip select, at the end of a transfer.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
..

-michael
