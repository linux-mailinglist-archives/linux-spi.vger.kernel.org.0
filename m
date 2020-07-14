Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E768F21EBBA
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 10:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgGNIsb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 04:48:31 -0400
Received: from mout.web.de ([212.227.17.11]:46467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgGNIsa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 04:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594716504;
        bh=657xU/XyB4tnfr32yGNOVfIho3ObAg38aWOJ2ik2nQc=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=iiHzhBB7kX2dmcip3UueM8avfOVgoY0tEuqqVZZKP9mtmz36eDaE27VIdiV0aLvcT
         lSQqKlvcPRuvA/ZzQDCIVa8zIF2wGCVfKWN7RQli4Zz63+suCrgFG+8Ij1p7NwXYvW
         dmOKmh4LXbSZZ5ZaABi7N6NGwrZqdQeQzm+lsDhg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.21.3]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHSp-1kOZZd2eG5-00WIp5; Tue, 14
 Jul 2020 10:48:24 +0200
To:     Clark Wang <xiaoning.wang@nxp.com>, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] spi: lpspi: add NULL check when probe device
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <40ba9761-3f51-3f7f-5026-eed613dbf6dc@web.de>
Date:   Tue, 14 Jul 2020 10:48:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JOILYCpiV6lAo9XxA9m6+Qu3qD7SYEsgNVYI9NnR6/AoqLb+2I0
 tziIYE5bNbqtMiX5XpdQ9XHypE4m07B6V5ncDfUPCXGS0t3H/Nic0T2DAx9NYSglXiGwa5Q
 dkpzzYrCOiqNdOykO0i0Vv1joI8limKx/PlIY1U4LQvclgC+83fu9BO/7g12lxhZ3OonknC
 OoYbQUOr/ifpPVLkKoSAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tyr5XWVW7aw=:N4bkXfOuQs3xZU57hnb0hL
 bOXjy61lpqb48Y8cqcfHDWdpb15vPQeRMMdYh66MLznh/6+/eSIGodfN8XChJJ1jb6JJksz0I
 HoIc09zrR+fwh3L8M/6Gj40qR1+EWyjBkc8t++Eqz2WFWXngxqEu+HvYib9BXoRuN13wLfztE
 V9zFGpH+l/aG0B/iFLDSkGfzjY4mpFhF91FpYv/0Y1SBGmdFGF3hKfk6FPqPc2HZ3GnfPVh3J
 GWPD2mSUtJqgbiMw2ZEAD/L5PirY+9aIIvJaO7dKusJHQYGthubO4Mg9oKwXpZBMnIgyV375x
 otMuFw3meNouuXYnRMwiKLRfKMcJ4uit50w1cohqTIlhd7i8R/9w00b728tLnb47hDz5sDmzz
 RQtNSwtmn2jJzqOYSS4RefL8RbWgDBeqTvt1UAk4s5R02wzqB0w/Ewr4IyUpogIhajxjehriz
 XmNtqovG6S1sVCgImYOHL/F7wzaB/YPDT6vZZ4Zp7PNli+Hy8HAc3/aaON+45n1GkUh2B2npb
 9M9ku1o95ihtxy42SYCF8c5FXnV9/lggg1D6xpcItfBclLoLA86gEs4WZvjb0hF/55orRBGBv
 YDWspUQw/fYbjNdTboSdWHKfBr0LLIdyBV3E5hxwTFCZuo7EqrrsUzsxF2ULTIbBANbKSlI1O
 SyLk0dk7UbYIdIjS7f5E/SK++ovie3KDJN0NlcchDT1YBcPzguctt7MxG1eocdRPxbQ3fquAC
 Gpv/Z3X97QHX44vzteV7u4CTlEyPXS3ynlH7bNaDMF2jG8FNQvwRohEVaGthUMtn4aZ/P0BK+
 MvLjuCCER3wnntt+4brLXophN4/dVDh9eGvTmMrkxq4h7YuMMS4Sw30n57GyCTyQFnI2nWQfv
 eVj75rhhVBQE4eZ7gzjeGstgGHFmz2lwNbl0dwRL3e0skSDgRevDwA3gi7S6F5uyghIQ21sSE
 jLK5UBQsBiU/bpl9voch7+Bf/GezwtP/MsBPqB98SEmfyxs8lVGq8VWCI7jR8Mzec4ofaug35
 gbzOWO0bp2DMLWxES5qtE7mOxC2VooP9jzmuS3wq0uPcXcvyuAnkqVeRzIKG/nPmYXTC5k6sq
 YyHBUjiMMUL/1tUaFmTcFGEILvjiZyvLqvLtpc9TlZDE0B0kFjb5wA1dMbNkGAXxMMx5YQzQF
 YMpsg+1hx4JCOuN9vhQj0+/p1ms0AA2g4dACKehUj/N135rCx5DTP/6NnGeBBOSy//tpDtvZZ
 YJbB6vxuNiL1PPWbDr+2Wrke21lXMES3bgjGHEQ==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

=E2=80=A6
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -841,6 +841,11 @@ static int fsl_lpspi_probe(struct platform_device *=
pdev)
>  	u32 temp;
>  	bool is_slave;
>
> +	if (!np && !lpspi_platform_info) {
> +		dev_err(&pdev->dev, "can't get the platform data\n");
> +		return -EINVAL;
> +	}
=E2=80=A6

How do you think about to combine these null pointer checks by the logical
operator =E2=80=9Cor=E2=80=9D instead of =E2=80=9Cand=E2=80=9D?

Regards,
Markus
