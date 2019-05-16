Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CD920163
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEPIhN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 May 2019 04:37:13 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38445 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfEPIhN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 May 2019 04:37:13 -0400
Received: by mail-wm1-f50.google.com with SMTP id t5so1171520wmh.3
        for <linux-spi@vger.kernel.org>; Thu, 16 May 2019 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X0zkQaio+t3Isoa+1OzyKr46ojREpowq03WuCew/y+o=;
        b=FEZMG5jokgF9IM3MW63+oH/owSHc9Mt7X0CRnpU2pQrFi2C9epmpieOJRTfULKW8s0
         1yEWzGF8PxCNCDcZIJv8ZcJDpWAYVe7gxLxMyku6POisarXUUXGoKtFteQLW3OFA5xjj
         vAk14fhTC6TniuPsQ1mJxrOZj89VvR0Ecnrn3LHm/SL6QwMZECtF9JMuq1rPzhJ/l1Rj
         YIYCSwuFdOWpqbDWX9tW23cCzlXh5HvaYL+s8iDAwcnvid8INbGQIRNfkNRUCnGkbGql
         E9+bG2syI737jg0HTlcqqduUo/+gtPZecsKZRufDJiK016wgQXfmDKlEP2eRoawi2F6U
         ihvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X0zkQaio+t3Isoa+1OzyKr46ojREpowq03WuCew/y+o=;
        b=JYETdooLTY1IV9roYDUTec4wIWtQ7UpePQIPaC6FPZCG5NPGA5gwuy6iEjpA/6qVld
         rHB6YouuBZGboQKor3akSZsIFUSNowD7F+70/iXi4Ixf57arV4D4TuNVl0+kUWfK+Q2Q
         7khQUcR93wDT2q3q1fBLB+F/lI9vB5x64TbOfXIgP9ta1fmwNhSXOus/OWsfSfnYimNd
         HH+2P5Oh1sDG0L6Em6DbZoyB7oVP9R2WwINe0AkAoaMVFPXJJ/wwmYh0cNkZoPvZNwVk
         34pVtDdC/gNPRii6qo9XRcVCIhzSVW+NTjaV8UXB9rsUqI5gXUE0jk2NM8jmZ6FkhkKc
         CCRg==
X-Gm-Message-State: APjAAAXY4v4omcnSjZ5k384dtjJI0U21uFRFEzbLVU90400FcTWTbHaJ
        gW829XCY0Sj4htsfPZie6QIsO+BNFYsd8/JMI50vwQ==
X-Google-Smtp-Source: APXvYqwF/2nWsGeagMYdw12EOcPA7geybvIqDdQIDsyNg9/UrIHWZzvOollMCLoIZ/RPJoJ3i9bQyYfjRnoOCEeVK/4=
X-Received: by 2002:a1c:a64e:: with SMTP id p75mr16072945wme.62.1557995831226;
 Thu, 16 May 2019 01:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190516075656.25880-1-yuehaibing@huawei.com>
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 16 May 2019 16:36:59 +0800
Message-ID: <CAFRkauCSzkuNUugsfGY8jvcy-2hd-LfkuerJi56V3OM6oHu3yw@mail.gmail.com>
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in spi_unregister_master
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Alban Bedel <albeu@free.fr>, lorenzo.bianconi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=8816=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> If spi_register_master fails in spi_bitbang_start
> because device_add failure, We should return the
> error code other than 0, otherwise calling
> spi_bitbang_stop may trigger NULL pointer dereference
> like this:

Reviewed-by: Axel Lin <axel.lin@ingics.com>
