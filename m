Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0289222965D
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 12:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgGVKjD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 06:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGVKjC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jul 2020 06:39:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804BCC0619DC;
        Wed, 22 Jul 2020 03:39:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f1so851919wro.2;
        Wed, 22 Jul 2020 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ITeNa3BddWkWg1sCq5YZx4M2tUONfLIipafvxs1VxQc=;
        b=n0KnHUnFLh8ve9V6D+dpbF/RXarLay2T1FnkRY8aIleKNbJnMeU9NVPDxhDfj++CFw
         OVz/Tceu1VUJJEqJw+lbrIa3A8k8o4c/pa9BQKdxlChPGEJ8YNeEN3ZNOlPLQLFJZ88T
         fdnjBcS/tor9pw19QZI3Yz32IEBj+aMVUo+tJCLTyzXySQds07hGaRcGI2kV/Qn6yJ0O
         w5FFzz050DBXrYURhLbVQzcnMP3n6/a5IkJmivHbTZpYOfMU4AxjKLeDDRmDZyaQq8Uk
         zBiWYk2lzk9ooLw5LH0MAa0oh6lIhmocxUDrFU9XjJcWBRbhNOG14Q1zpWYGMPiEycwS
         yQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ITeNa3BddWkWg1sCq5YZx4M2tUONfLIipafvxs1VxQc=;
        b=Yu/7x30h5kZABO1RkWBWfgXYzxvugD+DKhEw5EINOtL/7aqSVSH97d37s/qNSzFHaT
         Ska2qanIiCRj/0LZ86znxCvXgHptlRiNhpmSDWdZufoH13UqELVhXjzd9QX+237OvCaJ
         dtvuhQ4hps01WjE08eSQ4sOfJVTXOLuBVqH4WWvmOymkg0tlFXgfr2KlocXVt4RtVcxs
         Lhy7oERKgtJZXnR3XID33zIxwIkKyafVcaaSV0qx0gJEW2Nm7013//gWceYYwKHm9oPt
         2ynRTkg9f5Au1CyuwGT/YB6STNsQIu5+j3b3ZfWptFijYFhM5JVhVGpXzdwmONXwP+44
         pN5Q==
X-Gm-Message-State: AOAM530KG04YSF+KW31+rgqmv8ZD/sfSF+dSIDKQCH17R8FNyDIW+U6d
        V4E8yrM8ZLC54MffYVTSP1Y=
X-Google-Smtp-Source: ABdhPJwPB+DNdESb0CiW7c2gGxsBfsnvTy9nDsGNJjwB0czwP+nFniFmLYrTIsBgp7yUsAykIuCI9A==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr31200396wrl.246.1595414341264;
        Wed, 22 Jul 2020 03:39:01 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id z16sm40020579wrr.35.2020.07.22.03.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 03:39:00 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] spi: mediatek: add spi support for mt8192 IC
To:     lei liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20200721122436.31544-1-leilk.liu@mediatek.com>
 <20200721122436.31544-2-leilk.liu@mediatek.com>
 <27e48721-5e54-6947-cd8f-669f4da34c4d@gmail.com>
 <1595407127.31408.3.camel@mhfsdcap03>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e2736fea-748a-3359-ff04-3669103ec301@gmail.com>
Date:   Wed, 22 Jul 2020 12:38:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1595407127.31408.3.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 22/07/2020 10:38, lei liu wrote:
> On Wed, 2020-07-22 at 00:44 +0200, Matthias Brugger wrote:
>>
>> On 21/07/2020 14:24, Leilk Liu wrote:
>>> From: "leilk.liu" <leilk.liu@mediatek.com>
>>>
>>> This patch add spi support for mt8192 IC.
>>>
>>> Signed-off-by: leilk.liu <leilk.liu@mediatek.com>
>>> ---
>>>    drivers/spi/spi-mt65xx.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
>>> index 6783e12c40c2..3d0d69fe0c69 100644
>>> --- a/drivers/spi/spi-mt65xx.c
>>> +++ b/drivers/spi/spi-mt65xx.c
>>> @@ -170,6 +170,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
>>>    	{ .compatible = "mediatek,mt8183-spi",
>>>    		.data = (void *)&mt8183_compat,
>>>    	},
>>> +	{ .compatible = "mediatek,mt8192-spi",
>>> +		.data = (void *)&mt6765_compat,
>>> +	},
>>
>> That's not needed. We will use the fallback compatible which is
>> "mediatek,mt6765-spi" which will take the correct DT data. If in the future we
>> realize that mt8192 has a difference in the HW we can add the compatible.
>> Otherwise with the binding description we should be fine
>>
> So you mean that only the following binding patch is needed?
> [PATCH v2 1/2] dt-bindings: spi: update bindings for MT8192 SoC
> 

Yes, exactly.

Regards,
Matthias
