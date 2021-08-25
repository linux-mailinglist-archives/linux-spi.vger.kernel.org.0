Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666683F6F18
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 07:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhHYF6u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 01:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbhHYF6u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Aug 2021 01:58:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF626C061757;
        Tue, 24 Aug 2021 22:58:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x12so34547709wrr.11;
        Tue, 24 Aug 2021 22:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06re+8WkU5VebI6jGZJpR94faNEVrf1aGvqVrEKuNZ8=;
        b=pQ5mfYQkyicvUv+HmDsuJldwQaLH4mo5OLOFTL+ou3qR9/qkYRqQLEtalhbzKA7Hvk
         zkdUJORyKDHVh/pN1pAl8Tes20DF9t/fkmvrffnEDNMj3UZupTHh5hugmCC9nvwd9J6M
         o7zg83Ev+48a43qas7JNev+EclyLIPQqMMS6g7fYQjUOZiidfnwDXz/OvTzI197RwSSb
         0ByJH/Upur4ciZ7OVuIhFSb0cNmK87NyAqf51QEirytBxNM9NeG7PFXtyZq9qCfTZOoQ
         kOfCGspePDSdNqOWrL06N0sOcU6pDkYs3QUenSMtBuQXTPWygircD58JyJz1EQkXg52N
         Gx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06re+8WkU5VebI6jGZJpR94faNEVrf1aGvqVrEKuNZ8=;
        b=lKevcdkc2o3/tLZbp0bJESIonaA4cCne1AickdO8UqZKA2WTedIs5v5DaoYHfSpXWA
         zF4rIpvJrfNycZMQJPNrjOAxqoq35yyMiBZWxIv81fYUQKxI5L+Lv1t4M7j+WTmskDCe
         zuk0WLSV3gDzMt6Wm7SOE5DE58CDBqoFdWl03J8qtR+R/8hy6HIbuh87JyYRQ9syeH1J
         6uJuZJwi9YZmftiBmNdMV4UP2VgUtzKQkC/+RNzQ2pXn9Tf+PPsnIxjzMLA0lUBq8m5T
         9ukr/rD9r3Y4prb/p8WuwGa2erLSAG6ttrfNHfloCSzyIxdIOuEisbx3fgYzirxf61x1
         YVfA==
X-Gm-Message-State: AOAM532PTFUoY75c9xFWqeFgk8VqcWWNFHVNjxdHejm7jE2kF+u73l05
        v4ciIHGnpTrgmjtJ9ser+cVpiv9XXEbRXootIt8=
X-Google-Smtp-Source: ABdhPJzwzxF8orbHe3jSD7Uncwqg+1GJSzVyQKn+14id/SsYjNHfF5dA6n7ltPp7GgPDmJqj53j5yWUhmkjN8MIsKpw=
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr18746301wrm.198.1629871083425;
 Tue, 24 Aug 2021 22:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210824092745.2093640-1-zhang.lyra@gmail.com>
 <20210824092745.2093640-3-zhang.lyra@gmail.com> <20210824155823.GE4393@sirena.org.uk>
In-Reply-To: <20210824155823.GE4393@sirena.org.uk>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 25 Aug 2021 13:57:09 +0800
Message-ID: <CAAfSe-v3uJRu2qZ_zNeR-WRdy2U-BBtOdznHfL8k0QqGuXHscQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: spi: Convert sprd ADI bindings to yaml
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Tue, 24 Aug 2021 at 23:58, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 24, 2021 at 05:27:44PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Convert spi-sprd-adi.txt to yaml.
>
> It's better to put DT binding conversion patches as the last patch in a
> series, there's often a bit of a backlog on reviews for them so putting
> them after other changes means that the other changes can proceed while
> waiting for the review of the YAML conversion.

Yes, the last two patches are DT bindings, the last one is based on this.
Thanks for telling me, I didn't notice this indeed :)
