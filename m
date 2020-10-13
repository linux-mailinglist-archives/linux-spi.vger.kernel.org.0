Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75F428D352
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 19:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgJMRxa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 13:53:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36990 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgJMRxa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Oct 2020 13:53:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09DHrBvg074183;
        Tue, 13 Oct 2020 12:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602611591;
        bh=FBiVGwoGX+2mUnA4sFmVWy34xUiW+AdWJW1G01o5UV4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=PxlkB6W5UkUdhHF0rEt3joHxxmA/YoJqbNOqLK0vrs3/acz6+IKRTZ40Qt6LH9Bd2
         2HumgB1WcXMd/MU3kspuU9NFStl8lkDtca+CSMTe2vDQTDhAkHyjrfM5ZHiVgmO4Ob
         KhMb/YAGqcoImUQz3Cb483vkMDJrs+T9kUgHLkCA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09DHrBnD025384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 12:53:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 13
 Oct 2020 12:53:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 13 Oct 2020 12:53:11 -0500
Received: from [10.250.67.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09DHrAvE096079;
        Tue, 13 Oct 2020 12:53:10 -0500
Subject: Re: [PATCH 2/6] dt-bindings: mfd: google,cros-ec: explicitly allow
 additional properties
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-3-thunder.leizhen@huawei.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d2457f7a-625f-b046-9cfa-8f920de07377@ti.com>
Date:   Tue, 13 Oct 2020 12:53:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013160845.1772-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Zhen

On 10/13/20 11:08 AM, Zhen Lei wrote:
> There are so many properties have not been described in this yaml file,
> and a lot of errors will be reported. Especially, some yaml files such as
> google,cros-ec-typec.yaml, extcon-usbc-cros-ec.yaml can not pass the
> self-check, because of the examples. So temporarily allow additional
> properties to keep the comprehensive dt_binding_check result clean.

My preference is to fix the binding to pass the checks and not just work 
around the issues. Working around the issues may mean the issues never 
get fixed.

Dan

