Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD4516BF3A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 12:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgBYLAN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 06:00:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38062 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgBYLAM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Feb 2020 06:00:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01PAxki2096227;
        Tue, 25 Feb 2020 04:59:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582628386;
        bh=4SXC0So5Cf5UBNuGctQdmvRSYNGGE7hSlqUpZblF06M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mJps6WqQVeD5qiy57T3qc/hTqJRxnP2d4kJ6JIPQC/BmTDl3bIch8c4OiqY0++6oc
         hiIk9nyjxnaB0i4+ST4E6v/UkVYbOhD0XlP6rD3Fk+/pvDsoXGq6NeJvcyUvUsAvvm
         pqQNlImsDzmsXN0abhGSPhnPktDVRJAkGd6JkI58=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01PAxkTd077900
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 04:59:46 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 04:59:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 04:59:46 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PAxg21055523;
        Tue, 25 Feb 2020 04:59:43 -0600
Subject: Re: [PATCH v10 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        <simon.k.r.goldschmidt@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>, <tien.fong.chee@intel.com>,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200219022852.28065-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqKJky=y4nhECUFVzTYvEpjFoOH_6UY9uZG5bvBVWq=SYQ@mail.gmail.com>
 <64b7ab12-0c11-df25-95e7-ee62227ec7ec@linux.intel.com>
 <85178128-4906-8b1a-e3f1-ab7a36ff8c23@ti.com>
 <c119a70d-b7ef-ab1b-4590-7ac77395297f@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <8c329860-84fd-463b-782f-83a788998878@ti.com>
Date:   Tue, 25 Feb 2020 16:30:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <c119a70d-b7ef-ab1b-4590-7ac77395297f@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 25/02/20 1:08 pm, Ramuthevar, Vadivel MuruganX wrote:
>>>>> +
>>>>> +  cdns,fifo-depth:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description:
>>>>> +      Size of the data FIFO in words.
>>>> A 4GB fifo is valid? Add some constraints.
>>> 128 is valid, will update.
>> Nope, the width of this field is 8bits -> 256 bytes 
> 
> correct me if I am wrong, the width of this field is 4bits -> 128 bytes
> (based on QUAD mode) .

This has nothing to do with quad-mode. Its about how much SRAM amount of
SRAM is present to buffer INDAC mode data. For TI platforms this is 256
bytes.
See CQSPI_REG_SRAMPARTITION definition in your datasheet.

-- 
Regards
Vignesh
