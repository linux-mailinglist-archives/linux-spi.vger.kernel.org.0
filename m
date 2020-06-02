Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371981EC341
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgFBTzL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 15:55:11 -0400
Received: from mout.web.de ([212.227.15.4]:54503 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgFBTzK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 15:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591127692;
        bh=F130L1o0OUvgpE9qyzKTGdlhMZWHcJ6hkaBOlTJTk5o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZQ4haN4KxegQnDtQdYI7Y/CoWpq9YIlbKj7oR962NjvDRt0YEYFWBbWP6PlscFQLt
         iUs1mIkjnRS6WGGPrxsN1iEtxMEiMERTIVy8Vc4lgU2LJ5GKi4S4MhSL7bawFBr011
         F9lIPRXcp/7kMuV8/fFgLa5RQJhi04aFH07X0hLU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14ta-1izkOc08qo-012Vj8; Tue, 02
 Jun 2020 21:54:52 +0200
Subject: Re: spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get failure
To:     Mark Brown <broonie@kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <26028f50-3fb8-eb08-3c9f-08ada018bf9e@web.de>
 <20200602094947.GA5684@sirena.org.uk>
 <1c13e0ec-e50f-9eea-5704-052d2d682727@web.de>
 <20200602141306.GH5684@sirena.org.uk>
 <cc8e1397-c605-d73e-363e-9d2ddfb9ae16@web.de>
 <20200602183644.GI5684@sirena.org.uk>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1d1a4e7a-1c1e-efeb-ad61-5e4f1eeecab1@web.de>
Date:   Tue, 2 Jun 2020 21:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602183644.GI5684@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qKZvH10Jo4oc0hKzX8MpYzcMlovX+bheXGDCmpsOl7B+WoitNDc
 ExjDh6rueqMj9IiBUiUkOLIOH6EET+OWHj8w6i7DVBbEBbd5OYbPKCNsDv3GszPWTCTJnEk
 qUr8bs+F9tgGWiLAnxDzZA8YCEcEPnf77+Z1xxq7iBXeaVD6f73ClXG//gtFsIKiNq9q3lN
 y/VnJK6QOW51BBwQivocA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V3oRTXAfv3Y=:2CrUDXuECCzkf6OpfKe3aj
 YcKdwW1KddnBDJ7PkuHedvqHNhH2t2T5GLmcxI7Z+i6mBbZOTgI7SkAu4mITWyl9l56YfFjBO
 fzi2SSA/FkG8IeMFMtfUWePlnyqMGyUGIJnkEl4omgtMsevRIymu5+SnhrSBIrYjuDqEEW1Ov
 7G/K1E25Zb/r2lItNznBLfWfOctBA7nr3tO8c1glRobfW1Efrf4KVzMNEIw9mFVNPSGqDNBZ7
 QO8+LxCHfCLNJphJZZGETt+FgY1xIj6M8Ossjx5F+KrxDCozUIx5CeZJRWS8dI1X56CxOikE2
 Kuk+UTEYlrqmQXqpu7IP8s50pSCZrrMfi/tnZbALfXceWJfJVY2qg1dNpHA+0B/0garunmxhP
 2GVWp/jOzACAdmiUJg8USsUEbb2GZSrTT0WNyzcDgOkzxCvhsqm9K1XDxFWWs2D5WCwAuenbO
 Lg80TW5NiIFSF6qzCSX7GDDITimm4lcVeBaifSVbXYhV4jK/JYX6FyuPS+ftLl2KYLqQivcUT
 Fop/TQcnAwHxpI7pjX35ADSZBTUUd4ZdUKKnpfzo1/LH2oFyGTvtQ+8ZHi5GxdlN7I3jI7OSG
 kaLrhle3AW8zTpSVVf0oP5W6AXISfJxEsLhAiPIqnyM3IV66jfT0lKjx+QYAly5PU6wwCaHtK
 azXljt+dzN1gNbfceK9DgNakDdJ39nBjA98LUNP2ifTpuuWbSME2Vh8N6ONHopFXIr6rO6AL5
 dfhi686fNm+T067ZPoX87wgMtJOZQ6FyK92bit6HV/uBiTVMHMpcslKI+DWPOX8N7foGyCfUT
 eP9beI78skdDheNOXUnzjumq6fuFha5EvBxWPzcovj9XPZ83a2qs/sO5NqiVYHfv8+Gw8O5GF
 Qu6OulSpI/zkQhKmDqbkucymmdra3Ru1P1NKMeHBDy+9jXca+LXiixKs5iScQbMH0Ig+Gy6Nt
 vOLZtC43gD+MZ1J02ZoTYfRlGDeVnxka43CGNFpRUXBOYIchCBCqosli9R0GSCLCclmUYPB1Z
 GM/kPEB02Mb1Te8xlvnh5/lhJJySLbWoNrEv3BrIwFiyXH3HY0iYTS4aXMKSbvvhz8VD51Ccc
 wmstVenuFTOsOxovr5n2Zy3XIh40t1Pu4vGUlaKSTWBwtgQXnVmxPwawR+yRiZiOG95hSupMs
 yhnMDe7FFpCEU833fyMH8LprgAbofF1XaFuLppb+Uk/tKYQslt6rcARyJfz526baP7192rluo
 xsZj6wxd3OqrNnqG1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> Your updates were not improvements.

I find your view interesting.

Do you refer to a specific wording suggestion here?
https://lore.kernel.org/linux-spi/26028f50-3fb8-eb08-3c9f-08ada018bf9e@web.de/
https://lkml.org/lkml/2020/6/2/210

You pointed another programming alternative out.
https://lore.kernel.org/patchwork/comment/1447149/
https://lore.kernel.org/linux-spi/20200602095411.GB5684@sirena.org.uk/


> The formatting was worse

Do you prefer an other quotation style for function names?


> and to my native speaker eyes the grammar was worse.

I am curious if a more pleasing wording variant will be found.


> With this sort of stylistic thing it's especially important
> that any review aligns with the needs and practices of the subsystem,

Such an expectation is reasonable to some degree.


> there is opinion in there and multiple opinions just makes things harder
> for submitters.

Do any of such views deviate from the Linux development documentation?

Regards,
Markus
