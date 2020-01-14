Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7413B5FC
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 00:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgANXjL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 18:39:11 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51172 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgANXjL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 18:39:11 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E6C8F886BF;
        Wed, 15 Jan 2020 12:39:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579045149;
        bh=AlrvdzgXjpGDa7SNMjyhBnNMn4axze8b5Yq4/Y8xnRk=;
        h=From:To:Cc:Subject:Date;
        b=Lg0rW4rlK/jlRXPm8U0gngunNAFrHWqT1ZgaqLyIxfSYRd840vuA5N7RJQWoETPsm
         4dAkWkj/wWuusOLS6QqgBLWvz+7lHz1mdKKCceXk4f+srRZ1hoWhtyu/t/YzYvQ1Ad
         Phxy6P7b2+PhhyaUb+SJECL9aqZPAqeVLuP8BuwAhkDUORFNR2cXhv3ZWcMNLmMnmE
         ajI8lPqwy5TCA6t6Pzv+Y5cIHYN5VSA4+zcjKFS+/7GdAlVk8azyiTwLIhxNhZMn4S
         +N0z21B/1qQJDlcnYW2mUoFi+c5pag9cAPoKR3vO1m+lamlr/M+Gye3+cQmt0tfvn2
         CVDBqFmiCkHPg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e1e511c0000>; Wed, 15 Jan 2020 12:39:08 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 1227613EC73;
        Wed, 15 Jan 2020 12:39:08 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 5FAEA280071; Wed, 15 Jan 2020 12:39:08 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anthony.derosa@syscall7.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] SPI bus multiplexing
Date:   Wed, 15 Jan 2020 12:38:54 +1300
Message-Id: <20200114233857.25933-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a revisit of two earlier efforts to add more complex mutliplexing=
 to
SPI busses.

https://patchwork.kernel.org/patch/2706151/
https://patchwork.kernel.org/patch/10897255/

This version makes use of the general purpose mux controller which simpli=
fies
things greatly.

Chris Packham (2):
  dt-bindings: spi: Document binding for generic SPI multiplexer
  spi: Add generic SPI multiplexer

 .../devicetree/bindings/spi/spi-mux.yaml      |  82 ++++++++
 drivers/spi/Kconfig                           |  12 ++
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mux.c                         | 189 ++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml
 create mode 100644 drivers/spi/spi-mux.c

--=20
2.25.0

