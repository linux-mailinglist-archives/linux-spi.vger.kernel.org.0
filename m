Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47A1EB792
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 10:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgFBIk4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 04:40:56 -0400
Received: from mout.web.de ([212.227.15.3]:42407 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgFBIkz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 04:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591087235;
        bh=P4Sw0AHLKTABiGZ3F2jMUCU5oo6aGFO8jS0VkJZhLf0=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=gQRcnLNOPSlN1xXwb2GNhU8D5PxUACixEv8vfXRDthHA0f/JOgUEfNKrpD6z52602
         MkYXyeNcY/YJPNMS+xCXu31xtYkcI7nKD9+HqRPB+F9bb7wuuJ+ztYR1s85yidA7/g
         4jQatirh4klWlmgeufGTCr2Ui3MllqhmjcuKkhhk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhDRB-1jKMtO20cj-00MIdK; Tue, 02
 Jun 2020 10:40:35 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Mark Brown <broonie@kernel.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get
 failure
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
Message-ID: <26028f50-3fb8-eb08-3c9f-08ada018bf9e@web.de>
Date:   Tue, 2 Jun 2020 10:40:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xee8jVqmdupQA1Q8ogP5YuiQtLRQ4I4+pAbq5AURMwE8RLGuIP9
 7LiM7EiHiZ0HPJX8AmzBBrkCaIpy4/QiphB0ibCeXQNCGZiBeUqfIGC7VsfZXpeVYaVBq5t
 AED9UZ4ALHL9qXC+b9ssxB0/9ca+3zmUGQgO5h9Ad/V3N2fTj5Zb+wlU5Ojw1pM4/46qSTB
 0amh2Iqt7Tbm53IEpLYMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ODODpRg23Ik=:B3nRjOy2nFp9BF5hswpiI7
 n8gaObQtgDkcjMX1tx8/xn/dlRKPwh5Pw8pF6O62y0XLf1TXdygW1vSbTk+CPvovouP5zJLnl
 hlUYfamqfA8/BhriDtvblrtpPw9eRSv5R76gWLnDUGCW2sDmyxEsJPUD3uO86DUVVLMxB66EN
 xfbeAtVhyQ9PtKCVwwHupyKpVUgItqeIYbX/I6XoKAyjzaoGVDhLz5KREGwaiQjftbOh7TbRb
 QPyeO4zmdw92k+UxdB2j3+59Z/AXMyCanDDsoh8aJjThByRiIa0uQqaW96VgSE/gvMl53Goi5
 MaTeKzUKk9kXbsIeEgCRy9W5rVdh/JhVCegjkNIt9ab/SS2gRVeVi+BTa7gtJkDDbHxFq0waB
 GvAMQVzlPJk/LL1Y4BkxGQXn+1Q5AkoZyD23yYL/yM3eCrJlAVST6eGjbByjwy6cXVsNtGSc3
 Fr4l4HXsXFuWZudCl8f/ka9fUJP9N7+XMymEfPXY7EdVOsaE1FLq2TNAztIjMJ52clmi8x4yR
 xLFeMiOinfZnxB411YNWnthQJdX9i30yD76C3KKWUTIHVO+9mjlQZvmC88FFdYVfY36N2A1CB
 8kRi5McFPsYhOR2InXGO8QB5SG2U6frJTBKA78PebRXABs4226DhQLoZbbsgmtF/On5kWfjkb
 e5jn9/282HtaBa/2G2vPvfTCHf0BvYrWk5SMa8aiaP90LO0MLlOX+yrIpa8aWpzcC+o2sYNJ2
 d6ZmQxMVOO03z5j7r0AgRWNYCUL6YfgciGV6MzOhrWWJBYQhLE6oulxNuttWkT2h7tNjsLXgi
 t+U4rBzmRnu69temCXIG3DygLxonykUR4GmNEFQpGyLjKqcLGcwwnpCabgX+46aOk5zzCscAT
 iMaNm9ezuCO/u3oF56nSQZCkkvfzItsbdMAFqoHTjhpj3GJ3YbIu27IpEtE+DFJE8zYa2Ekwo
 NlCcm99dyGseELgaEDnTYKhH/ZdfQabnqamoKU75tn+eIMlAXuIT/DZU2euXluXYl2FnusyqL
 Ag091GWrimsad0RPZY9T0+DhXKDFzK3gvZyRA6w0WLIrA6Nu0sY7JAWr9W53JvpaHbOdsjTOl
 EaO1fKibCN+WUvIWcEcPE5sWRm4UQywr7vf9j2YaYNeZkwQ+5qLAgTY90COE223kGiumD+eF8
 JJb9cWMRzNEdFy9BZG5R3qIXfbSyQFFDhdmzt9maXoVZ/wQd9W5RRTnApyaMeZbh93FP0QdjK
 q+iSxoVUD7wqaWPF6
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> The counter is incremented via pm_runtime_get even in failure case.
> To correct the counter call pm_runtime_put in case of failure, too.

How do you think about a wording variant like the following?

   Change description:
   The PM runtime reference counter is generally incremented by a call of
   the function =E2=80=9Cpm_runtime_get_sync=E2=80=9D.
   Thus call the function =E2=80=9Cpm_runtime_put_autosuspend=E2=80=9D als=
o in one error case
   to keep the reference counting consistent.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
