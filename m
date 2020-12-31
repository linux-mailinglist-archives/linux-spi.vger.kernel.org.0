Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C832E7EDE
	for <lists+linux-spi@lfdr.de>; Thu, 31 Dec 2020 10:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgLaJJP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Dec 2020 04:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgLaJJP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 31 Dec 2020 04:09:15 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133EC061799
        for <linux-spi@vger.kernel.org>; Thu, 31 Dec 2020 01:08:34 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kutwf-00AtqY-7c
        for linux-spi@vger.kernel.org; Thu, 31 Dec 2020 10:08:33 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:a555:6f6b:beff:dc54]
        by yawp.biot.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kutwa-00Atq6-15; Thu, 31 Dec 2020 10:08:28 +0100
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: spi: Realtek RTL838x/RTL839x
 SPI controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201229231904.2558916-1-bert@biot.com>
 <20201230135156.GF4428@sirena.org.uk>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <5fdb1361-3e12-9c44-d570-7e8404db4f17@biot.com>
Date:   Thu, 31 Dec 2020 10:08:27 +0100
MIME-Version: 1.0
In-Reply-To: <20201230135156.GF4428@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/30/20 2:51 PM, Mark Brown wrote:
> On Wed, Dec 30, 2020 at 12:19:03AM +0100, Bert Vermeulen wrote:
> 
>> +properties:
>> +  compatible:
>> +    const: realtek,spi
> 
> It is possibled Realtek might make other SPI controllers, there should
> be some more specific name such as a compatible for each SoC that the
> controller appears in or an IP name if one is known.

Mark,

Good call. We're changing all the Realtek RTL838x/RTL839x stuff to some
variation of "realtek-rtl", in this case "realtek,rtl-spi". The "rtl"
prefix to Realtek SoCs fits the bill. Will resubmit.


-- 
Bert Vermeulen
bert@biot.com
