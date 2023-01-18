Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643AD67206F
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jan 2023 16:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjARPCd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Jan 2023 10:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjARPCR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Jan 2023 10:02:17 -0500
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552B367E0
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 06:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=kicherer.org; h=
        mime-version:date:from:to:cc:subject:in-reply-to:references
        :message-id:content-type:content-transfer-encoding; s=k1; bh=14O
        ufMgjG2qC3itc1uMB8npDZTfnLmoIqjxKEWNG2xY=; b=E25ZUgiQVWQG1Btjpru
        gDFtuhJBblIDCJUhH832gGE6yPOUmz0OPJkIGqmsKIDEt3CZINKEXp4CrrTOSgQq
        UV81QyaAG2TrkMI0fbr9RdtlCUME0H8Dr2fwsrvyvn5AXOmypkeADLCK9l5v8Bk7
        CqCADsXG4fydQHRyfumE0ovo=
Received: (qmail 1552619 invoked from network); 18 Jan 2023 15:58:48 +0100
Received: by mail.zeus06.de with ESMTPA; 18 Jan 2023 15:58:48 +0100
X-UD-Smtp-Session: l3s6476p2@DK+5DYvyCKTCdf4e
MIME-Version: 1.0
Date:   Wed, 18 Jan 2023 15:58:48 +0100
From:   Mario Kicherer <dev@kicherer.org>
To:     "han.xu" <han.xu@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
        broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional
 sampling-delay
In-Reply-To: <20230117210500.oimf4yjkkqh3o4hi@umbrella>
References: <20230116115050.2983406-1-dev@kicherer.org>
 <20230116115050.2983406-2-dev@kicherer.org>
 <20230117141057.GA2991740-robh@kernel.org>
 <85967a3fbce7051449f8d2b29ce5a47c@kicherer.org>
 <78fcf85f-b56b-79d1-f2fe-c038f424c72d@linaro.org>
 <20230117210500.oimf4yjkkqh3o4hi@umbrella>
Message-ID: <c11967cae4bebba15c719e6609a7c01c@kicherer.org>
X-Sender: dev@kicherer.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Han,

on my SoC (LS1021a), the QSPI clock is derived from the CPU clock 
(cluster1)
and neither is controlled by the Linux kernel (afair) but by the RCW (or 
U-Boot).
I could create a function to read the corresponding registers but I do 
not know
where I should place this function and how I should call this function 
in a
portable way in the QSPI module to convert the nanoseconds into delay 
cycles.

I thought this would be a small and simple patch but I guess these 
changes will
require quite some time with my knowledge level that I do not have right 
now.

Thank you all for the review!

Best regards,
Mario

On 2023-01-17 22:05, han.xu wrote:
> On 23/01/17 06:10PM, Krzysztof Kozlowski wrote:
>> On 17/01/2023 17:33, Mario Kicherer wrote:
>> > Hello,
>> >
>> > unfortunately, the rx-sample-delay-ns property does not fit here, as we
>> > can only delay
>> > the sampling point between zero and three "half cycles" (or edges), not
>> > by an arbitrary
>> > number of nanoseconds.
>> 
>> Why this is a problem for FSL but not for other platforms having 
>> exactly
>> the same constraints/property?
> 
> Hi Mario,
> 
> Please use the common delay in DT and calculate to half cycle in 
> driver, we have
> the similar discussion before for fspi controller delay settings.
> 
>> 
>> Best regards,
>> Krzysztof
>> 
