Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC5A95C5
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfIDWLP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 18:11:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38814 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIDWLP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Sep 2019 18:11:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so255977pfe.5;
        Wed, 04 Sep 2019 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g+6XpI5kpbmJFvx+kn5E+7tLpc2ZjDJn4kNPVnStE2E=;
        b=e1kzHrrhLu3H38c3RIvFv3KFtEH9I0ixuhaalyVNjtJ9R9aUU9517BP85uBp4c3dZa
         6DzLL79w3ZVR5oUpFF/Hw+HQ2RxOZQDPC4namhjt2TAkIKilTLiQFyR+o1Yj1In2zXDy
         9561wWBcfEh/Zda6ZBhNy8ZYUbEjDEGuuVxdntn6eA19ptbxtScB4jIDbgcIcsKHJIZ1
         6opBQ9JuYPHFhzVctBZsgYo4yGvrC/82132vAGrfZQnOnHxDOQVUV1WH8OPdd1L0DUNY
         WmBC0oBFQP6xLAELnWxBOYfrAUFMrzCd0Yz/tso+7YQkzY4u3U6ofekBVa0W6M1OSYGG
         qZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g+6XpI5kpbmJFvx+kn5E+7tLpc2ZjDJn4kNPVnStE2E=;
        b=fFXaeSowFzFKieC96Y+qeHGi2+JWVDwI+nIInjR/Iotw4FsZvgF1bWwZvxVLyaejSY
         z3QR0TplrKjRSL5qtpRyJsnKML/PdTP3crxXPM8wdp+Dmg63BeASDTrliIEKZTZTlJHa
         A2wfAxwvkCfmE0Yel+ivtuO7vMXJ66dPPyhebQZn4rNtnMwA/yRlPLZI15CMB5GTS/Q6
         lBDIzEUphrq8ribwGnc0WFqlpWTpYRM3juh9099S0Svq7P3Q3kWcL0Nmn0JTtPuSE5eb
         L/xqs1K8DXY76Dr/VwDFkYN19cagN62L022Hm/io7tGRXXcDHTfuoeSl5s0Kcya4NJey
         YvCw==
X-Gm-Message-State: APjAAAVg8rk1MGVaaNRt79TVdiO8/hnON+TG1sf4Wb3yN6meGVjWiq1r
        qC41cZMvJ+atC/zc5kXWTbh0pbF8MWo=
X-Google-Smtp-Source: APXvYqzpBWtpxdm0bH8OBicigR1zPs24mRFeZDv7CLPJ6+TDtcXf9xj9XjfGvwWIe6hpB9xzS3uiMw==
X-Received: by 2002:a63:7a01:: with SMTP id v1mr330595pgc.310.1567635073535;
        Wed, 04 Sep 2019 15:11:13 -0700 (PDT)
Received: from [10.230.7.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e192sm55781pfh.83.2019.09.04.15.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 15:11:12 -0700 (PDT)
Subject: Re: [PATCH -next 07/36] spi: bcm63xx-hsspi: use
 devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org,
        rjui@broadcom.com, sbranden@broadcom.com, eric@anholt.net,
        wahrenst@gmx.net, shc_work@mail.ru, agross@kernel.org,
        khilman@baylibre.com, matthias.bgg@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, kgene@kernel.org, krzk@kernel.org,
        andi@etezian.org, palmer@sifive.com, paul.walmsley@sifive.com,
        baohua@kernel.org, mripard@kernel.org, wens@csie.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-tegra@vger.kernel.org
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-8-yuehaibing@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d36f7e5f-d629-dcad-61c5-fcf896cbd91e@gmail.com>
Date:   Wed, 4 Sep 2019 15:10:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904135918.25352-8-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 9/4/2019 6:58 AM, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
