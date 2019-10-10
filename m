Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2592BD2014
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2019 07:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfJJFhd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Oct 2019 01:37:33 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:6640 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfJJFhd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 10 Oct 2019 01:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570685852; x=1602221852;
  h=mime-version:from:date:message-id:subject:to;
  bh=Xy0xPpkULCnt+hL55gCdlyQRWZEjRD9Fr0UAvbyShXo=;
  b=Qleu/qukLdLO4W8q/aEq5JQuZQSqab16XbaWuGTlSyaUiVgOHgTLeJJb
   Z3LH7yIBT2rKx9cH/oHhzgTbh9Zuezc/KkRJNTK5ObCoV7X6C/NIFVgr/
   2PcdZHBzXjn61H0jPkzegKlxzkJJSeDl+GHLdySCZfAR7amWJFpxFmr+B
   uYHzXaP2+Y2W+xVclxS4F95bH4+QdAPsGobFvphWB/FIgoJxpHsa9mhAi
   UAgTrgezPzeGNi6oZMX6QAppgIc9iZHkjeE/tOPts4I0kH6VrxHT82K82
   iOFnRpISLGgiq/JYnpgS/C0EnXwPHKfrq0t+nru5Sv05v036Xn7hCkylG
   A==;
IronPort-SDR: tD+lUv6XWhVYxOgzhlRA8HU5FFjZxZoBZTfCi/ohZGiacb5aP0DySym871Gc3LHv2+uTECEe6B
 CsogLOMpvyeglhYiZ2LgNAVUz80vPJgzYIKiqQgextP5XUXzvSsjFdn4yf2/xwaJPRzrJIEqTZ
 yIbCuZUm/jSl+gcQbCC0ND9qhyBjC7on1UNsul7lGLohOgKrYt1hbVeq3O9f6uY0Aw7GMdobxp
 BrVH0WhTdsG7lh/P/pgBGPFOvayaHXGQSwNtbn3EFzsFdFF6YzVs+tRoTqSaJCIrNkV5jsc8SA
 prc=
IronPort-PHdr: =?us-ascii?q?9a23=3A+fgOpB9zSaENbf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B32+4cTK2v8tzYMVDF4r011RmVBN6dtagP2rqempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCC8bL9sIxm7qQbcvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/9KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe84RS2?=
 =?us-ascii?q?hcUcZLTyFODYOyYYUMAeQcI+hXs5Lwp0cSoRakGQWgGP/jxz1Oi3Tr3aM6ye?=
 =?us-ascii?q?MhEQTe0QMiHtIPsXTUrMjyNKwPUu+1zLPHzTTeZP5R2Tb86YjIfQogof2QQb?=
 =?us-ascii?q?59f9HcyVQzGAPflFmft5HqPy6M2+kLrmOV7PJgWPqxh2I7rwx9uDuiy8c2ho?=
 =?us-ascii?q?XUh48YyErI+CdnzIszONa2UlR0YcS+H5tVryyaMox2Td48TGxwoyY6z6EGuY?=
 =?us-ascii?q?a8fCgX1JQr3x7fZOKDc4iP+h/jUfyeITZ8hH58fLK/iQu+/VGuyuD+SMW4yl?=
 =?us-ascii?q?lKri1CktnDsnACyQbf5dSASvt45kuh2DCP2B7P6uxcP0w4ia7WJ4Qiz7MwjJ?=
 =?us-ascii?q?YfrEXOEy3slEj0kqOabkAk9fKp6+TjbLXmvJicN4pshwD+M6UumtawAeUkPg?=
 =?us-ascii?q?QSUWWW4vm826H5/UHjXrpFk+A2nrHDsJ/GPcQburK5AwhN34Yn6ha/CSqm0d?=
 =?us-ascii?q?sBkXkcNFJFeQmKj5bmO17QOvD0F/S/jEq2kDdt2f/GOqftApLXLnjMw//deu?=
 =?us-ascii?q?NY4lRfgCApys9Zr8ZeELYGJvP+ckz8rtrVClk+KQPih67jCdNgxsYFQWOnHK?=
 =?us-ascii?q?CUKuXRvEWO6+ZpJPODIMcRuTDgO70m6uTogHsRh1AQZ++q0IERZXT+Ge5pZw?=
 =?us-ascii?q?2rYXv9n9FJKGYDuEJqXuzrmUCESBZYfDCvVLh66z0mXsbuJofOQI+8nfS62y?=
 =?us-ascii?q?G0VsldfWdABXiHCjH1fJ/CVvsRPnG8OMhkxw0FR7i8TMcT1Riv/Fvr2bpuL7?=
 =?us-ascii?q?KMoQUFvoil2dRosb6A3Sou/CB5WpzOm1qGSHt5yyZRH2c7?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FRAwDEwp5dh0inVdFlDoZEhE2OXIU?=
 =?us-ascii?q?XAY1pijQBCAEBAQ4vAQGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCm?=
 =?us-ascii?q?FQII6KQGDVRF8AwwCJgIkEgEFASIBNIMAgngFpCeBAzyLJoEyiGUBCQ2BSBJ?=
 =?us-ascii?q?6KIwOgheBEYJkiD6CXgSBOQEBAZUvllcBBgKCEBSMVIhFG4IqAZcVji2ZTw8?=
 =?us-ascii?q?jgUaBezMaJX8GZ4FPTxAUgWmNcVskkUsBAQ?=
X-IPAS-Result: =?us-ascii?q?A2FRAwDEwp5dh0inVdFlDoZEhE2OXIUXAY1pijQBCAEBA?=
 =?us-ascii?q?Q4vAQGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6KQGDVRF8A?=
 =?us-ascii?q?wwCJgIkEgEFASIBNIMAgngFpCeBAzyLJoEyiGUBCQ2BSBJ6KIwOgheBEYJki?=
 =?us-ascii?q?D6CXgSBOQEBAZUvllcBBgKCEBSMVIhFG4IqAZcVji2ZTw8jgUaBezMaJX8GZ?=
 =?us-ascii?q?4FPTxAUgWmNcVskkUsBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="81375093"
Received: from mail-lf1-f72.google.com ([209.85.167.72])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 22:37:32 -0700
Received: by mail-lf1-f72.google.com with SMTP id m24so1065884lfh.22
        for <linux-spi@vger.kernel.org>; Wed, 09 Oct 2019 22:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vkLjkXwl3hWsyvy/ZQWrrN8uTBfkFbAgqdrjHxTVCjA=;
        b=DhDv2fc4U81VMaC+TZV4poUjHhtYlNK07+C8Bi77LjusNezjT4jIbjIrbRmv+1fdX0
         4lXQpBT3SKH6zp8uX0wx273i4wM5RF16GEAJLF7zEJRV5C/yvxAmlqRbXxUi+XyAkHul
         LCaKVppt2PHu1AUgRGFD0fLtRBDyvNRobiZ8jsWwVTTgamtnZroCA7bN46bi4rJUm4je
         daNuciaH2Vz1CZQKFi9eGL2piT+Kd5BUDbi+Bg1JLl5vOCOyXe9cU2qMtgFbDvnfhJPI
         ywC6NoKm5HjNU/rxYq5JaXOqhdkLq69Zcy0kT8rJnie1Whwcrc7zey/sSycbvNGRKDip
         5EOw==
X-Gm-Message-State: APjAAAUK40PalT5N+MIGtmhbEDSwdHRg7hKEYq9xkxTiX/3KDQEUXVU1
        eEMfqIixy/BPBKw+HOyLrOvf7RXg//wTOWUNn84s1DBiYN69S9iUP78t2beSC7W+iLkNrPVFCBF
        Jrttdlt2uGZhTrqrJ6tbOG9HNA9khB549weGtSg==
X-Received: by 2002:a2e:6c0e:: with SMTP id h14mr4946633ljc.92.1570685850368;
        Wed, 09 Oct 2019 22:37:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBa7eGL1/6qnPzIY6RKFJAtUZRnNcZZsQw99WnHp6fw/68G9kF7paHHurL0HqgrVYHa5tUDuOi5ELJRyEjQXc=
X-Received: by 2002:a2e:6c0e:: with SMTP id h14mr4946609ljc.92.1570685849997;
 Wed, 09 Oct 2019 22:37:29 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 22:37:04 -0700
Message-ID: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
Subject: Potential NULL pointer deference in spi
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All:

drivers/spi/spi.c:

The function to_spi_device() could return NULL, but some callers
in this file does not check the return value while directly dereference
it, which seems potentially unsafe.

Such callers include spidev_release(),  spi_dev_check(),
driver_override_store(), etc.


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
