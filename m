Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED572EA6B5
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 09:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbhAEIor (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 03:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbhAEIoq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 03:44:46 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74750C061795
        for <linux-spi@vger.kernel.org>; Tue,  5 Jan 2021 00:44:06 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kwhwi-00Bks0-Rj
        for linux-spi@vger.kernel.org; Tue, 05 Jan 2021 09:44:04 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RDNS_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [85.234.217.28] (helo=[10.0.1.5])
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kwhwd-00Bkrb-M4; Tue, 05 Jan 2021 09:43:59 +0100
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: Realtek RTL838x/RTL839x SPI
 controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210101132432.2785663-1-bert@biot.com>
 <20210101132432.2785663-2-bert@biot.com>
 <20210104213131.GL5645@sirena.org.uk>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <121d9dc6-7993-d43b-291f-74dd943f4fc6@biot.com>
Date:   Tue, 5 Jan 2021 09:43:59 +0100
MIME-Version: 1.0
In-Reply-To: <20210104213131.GL5645@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 1/4/21 10:31 PM, Mark Brown wrote:
> On Fri, Jan 01, 2021 at 02:24:31PM +0100, Bert Vermeulen wrote:
> 
>> +  compatible:
>> +    const: realtek,rtl-spi
> 
> This is still just using rtl-spi as the compatible string, please
> address the feedback on the previous version.

Mark,

The rtl prefix really is as close as it gets. This is being developed on 
RTL838x and RTL839x, but the driver very likely also works on RTL8196C and 
RTL93xx series. There's no difference to the SPI block in those SoCs.

Do you really want a different per-series compatible when the "IP block" was 
just copy-pasted between series in hardware?


-- 
Bert Vermeulen
bert@biot.com
