Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783A239D6E5
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 10:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFGIS0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 04:18:26 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43671 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFGISZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 04:18:25 -0400
Received: by mail-ed1-f54.google.com with SMTP id s6so19225493edu.10;
        Mon, 07 Jun 2021 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K89JEvr85cNLVGSNruqsSq3SJC58qTPUfjZOJypE398=;
        b=eCJfDnUWsGlw5Enrdk3Jns3FXgd6MMJQpD3UOt8lHyRMIu98184qLWZkiRLljwqJxY
         5OcWiejI3nEYcgYhlnsOrllVQH3cE02D/gkfrDK1+lwK6jTjAMLbwpFOp3CKyB/j0AnL
         xPOMjbC2NfV9eSBhhbKGOV3NN7xQ8/n9qXd3Mnvixwmt4UPMxgNcK3dVviOXbrMhoq1u
         tJrJkdgzM6SUwfTcyCvrHaHOQKhpmeOAixxRVBXQZFpE7Fd2s6bZZ2RDTPFz24ZzkVLO
         NpXifHVREn/tJ1BEZZe6V6RolRTnvv9zvyxjMh1ogLwdq3n7mKcE/rrrwrd/JPei0IbB
         D9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K89JEvr85cNLVGSNruqsSq3SJC58qTPUfjZOJypE398=;
        b=cDDIe6VsRovbt3gRx7Vuj7caGXaJMCJi3moF9qyK3h8ArIGJ7w2MbXxZKTcXeVGBpR
         pomcZ63ehz3pcRUZjFwNvEPzPjXUQSIVpmJiAPH3zEfm3DAKl9Cfm/YTxD4mkD1dMdDE
         r8f3BszJ1XjPptIzgxfNlL448f6KOiE+LamVancvsMMXGXElPinWjBkpY70jRJ+otyR5
         H31yhZ6VzwXvxlqSTtObLzoqiRKUtPuF06a3EI/xVMbS7gSY7zO7F1N3liR82j4wERbR
         cDA1eDcB/Z1p3wcRZTKg2wtVarrVaHop6OjQJ3nox5c0FA2iOz8eFz7smxoKOh8gIeQd
         CFSg==
X-Gm-Message-State: AOAM530zbd9tXB1n6sIUuWkaw0AcDczCBkjAJvM1kwq1vUIgW/0Swtku
        X0IT82npqgnormEJsYjXQ+o=
X-Google-Smtp-Source: ABdhPJx9aAufKoe/BlIe2Lu+49fT2xA4KIvgNKER4pcSOqtT/92ok2Sr4TA6thgdE7uipk5OwvgncQ==
X-Received: by 2002:a50:fb8f:: with SMTP id e15mr18105598edq.46.1623053733932;
        Mon, 07 Jun 2021 01:15:33 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z22sm5766732ejm.71.2021.06.07.01.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 01:15:33 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] dt-bindings: spi: spi-rockchip: add description
 for rv1126 and rk3568
To:     Jon Lin <jon.lin@rock-chips.com>, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210607063448.29589-1-jon.lin@rock-chips.com>
 <20210607063448.29589-2-jon.lin@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <ef90ae6d-40bb-8389-f4f8-536a7b610fb7@gmail.com>
Date:   Mon, 7 Jun 2021 10:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210607063448.29589-2-jon.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jon,

On 6/7/21 8:34 AM, Jon Lin wrote:
> The description below will be used for rv1126.dtsi or rk3568.dtsi in
> the future
> 
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v4:
> - Adjust the order patches
> - Simply commit massage like redundancy "application" content
> 
> Changes in v3:
> - Fix compile error which is find by Sascha in [v2,2/8]
> 
>  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> index 1e6cf29e6388..2d7957f9ae0a 100644
> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> @@ -27,12 +27,14 @@ properties:
>        - items:
>            - enum:
>                - rockchip,px30-spi

> +              - rockchip,rv1126-spi

This list is sort alphabetically.
Move "rockchip,rv1126-spi" below "rockchip,rk3568-spi"

>                - rockchip,rk3188-spi
>                - rockchip,rk3288-spi
>                - rockchip,rk3308-spi
>                - rockchip,rk3328-spi
>                - rockchip,rk3368-spi
>                - rockchip,rk3399-spi
> +              - rockchip,rk3568-spi


>            - const: rockchip,rk3066-spi
>  
>    reg:
> 

===

Your comment in [PATCH v3 3/8]:
>> Adding "rockchip,rv1126-spi" to rockchip_spi_dt_match[] is strictly not
>> needed when using "rockchip,rk3066-spi" as fall back string.
>> Could a maintainer advise?
>>
>> Maybe this bug of mine should revert too?? Or is it legacy?
>> spi: rockchip: add compatible string for px30 rk3308 rk3328
>> https://lore.kernel.org/r/20200309151004.7780-1-jbx6244@gmail.com

> I agree with you. If the maintainer doesn't have any comments, I will use
> "rockchip,spi" as compatible names for the subsequent rk platform.

Compatibility strings are supposed to be SoC orientated.
So generic ones like in the manufacturer tree can't be used here.

===

Johan
